require 'csv'
module Umbra
  module CsvUpload
    
    # Calling function to update records from passed in CSV file
    def update_records_from_csv csv_file, encoding = "windows-1251:utf-8"
      # Get hash of authorized files
      pid_namespace = csv_file.original_filename.split(".")[0]
      pid_file = "#{Rails.root}/tmp/pids/#{pid_namespace}_csv_upload.pid" 
      @warning = "This file is already being uploaded." if File.exists? pid_file
      
      FileUtils.mkdir_p File.join(Rails.root, "tmp/pids")
      File.open(pid_file, 'w'){|f| f.write Process.pid}
      
      begin
        from_csv_to_db(csv_file, encoding)
      ensure
        File.delete pid_file
      end
    end
    
    # Verify that the CSV is actually a CSV
    def is_valid_csv csv_file
      (csv_file.content_type == "text/csv")
    end
    alias_method :is_valid_csv?, :is_valid_csv
    
    # Pull fields out of the CSV into db
    def from_csv_to_db csv_file, encoding
      ActiveRecord::Base.transaction do
        CSV.foreach(csv_file.tempfile, :headers => true, :encoding => encoding) do |row|
          # Array.zip merges corresponding elements from headers, then we cast assoc array as a Hash with the first element being the id
          # User can only update records he has access to
          if current_user_has_access_to_collection? row["nyu.libraries.collection"]
            #Create a hash of expected facets to add with acts_as_taggable
            facets = { :extent_list => [], :subject_controlled_list => [], :subject_tag_list => [], :coverage_spatial_list => [], :coverage_temporal_list => [], 
                       :coverage_jurisdiction_list => [], :source_list => [], :language_list => [], :accrualPeriodicity_list => [] }
            facets_insert = {}
            #For each field in row, add facet to appropriate array
            row.each do |field|
              unless field[1].nil?
                facets.keys.each do |facet|
                  facets[facet].push(field[1]) if field[0].eql? dc_format(facet)
                end
              end
            end
            
            #Map each facet array to acts_as_taggable list 
            facets.keys.each {|facet| facets_insert.merge!({facet.to_sym => facets[facet.to_sym]}) }

            #Generate record, or find if CSV contained a unique ID matching to original-id
            record = Umbra::Record.find_or_create_by_original_id(row["guid"])
            #Update attrs in the record and merge in facets
            record.update_attributes({
              :collection => row["nyu.libraries.collection"],
              :title => row[dc_format(:title)],
              :identifier => row[dc_format(:identifier)],
              :description => row[dc_format(:description)],
            }.merge(facets_insert))
            #csv_records[row.fields[0]] = Hash[row.headers[1..-1].zip(row.fields[1..-1])].delete_if {|key, value| key.nil? || value.nil? }  
          end
        end
      end
      #mappings = { "nyu.libraries.collection" => :collection, "dc.title" => :title, "dc.identifier" => :identifier, "dc.description" => :description }
      #csv_records.keys.each {|a| Hash[csv_records[a].map {|k, v| [mappings[k], v] }] }
    end
    
    def dc_format facet
      facet.to_s.split("_list")[0..-1].split("_").unshift("dc").join(".")
    end
    
    # Hash of records to upload
    def csv_records
      @csv_records ||= {}
    end
    
  end
end