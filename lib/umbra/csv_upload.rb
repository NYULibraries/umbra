require 'csv'
module Umbra
  class CsvUpload
    
    # Initialize uploading process with some top-level error handling
    def csv_upload(csv_file)
      # Did the user submit a file?
      if csv_file.present?
        # If this is a valid CSV file, proceed to uploading
        if csv_is_valid? csv_file
          csv_setup_upload(csv_file)
        else 
          return "File must be in CSV (comma-separated values) format."
        end
      else
        return "Please select a file to upload."
      end      
    end
    
    # Calling function to update records from passed in CSV file
    def csv_setup_upload(csv_file, encoding = "windows-1251:utf-8")
      # Setup PID namespaced files so we know what's currently running
      pid_namespace = csv_file.original_filename.split(".")[0]
      pid_file = "#{Rails.root}/tmp/pids/#{pid_namespace}_csv_upload.pid" 
      pid_failed = "#{Rails.root}/tmp/pids/#{pid_namespace}_csv_failed.pid" 
      
      # Same file cannot be uploaded again while still running
      return "This file is already being uploaded." if File.exists? pid_file
      
      # Make PID file
      FileUtils.mkdir_p File.join(Rails.root, "tmp/pids")
      File.open(pid_file, 'w'){|f| f.write Process.pid}
      
      # Upload records
      self.delay.csv_upload_from_csv(csv_file, encoding, pid_file, pid_failed)
      
      return "Indexing batched records in background. Please be patient."
    end
    
    # Wrapper to call push into DB asynchronously with delayed_job
    def csv_upload_from_csv(csv_file, encoding, pid_file, pid_failed)
      begin
        csv_to_db(csv_file, encoding)
      rescue
        File.open(pid_failed, 'w'){|f| f.write Process.pid}
      ensure
        File.delete pid_file
      end
    end
    #handle_asynchronously :csv_upload_from_csv
    
    # Verify that the CSV is actually a CSV
    def csv_is_valid(csv_file)
      (csv_file.content_type == "text/csv")
    end
    alias_method :csv_is_valid?, :csv_is_valid
    
    # Pull fields out of the CSV into db
    def csv_to_db(csv_file, encoding)

      CSV.foreach(csv_file.tempfile, :headers => true, :encoding => encoding) do |row|
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
        end
      end
    end
    
    # Get proper dublin core format from databse friendly version (i.e. subject_tag_list => dc.subject.tag)
    def dc_format(facet)
      facet.to_s.split("_list")[0..-1].split("_").unshift("dc").join(".")
    end
    
  end
end