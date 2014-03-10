##
## Class for handling batch uploads from CSV
##
require 'csv'
module Umbra
  class CsvUpload
    include Umbra::Collections
    attr_accessor :csv_file, :current_user
    
    def initialize(csv_file, current_user)
      @csv_file = csv_file
      @current_user = current_user
    end

    # Initialize uploading process with some top-level error handling
    def upload
      # Did the user submit a file?
      if csv_file.present?
        # If this is a valid CSV file, proceed to uploading
        if is_valid_csv? 
          csv_to_db
          return "Successfully loaded CSV records into database. Reindexing will take a moment."
        else 
          return "File must be in CSV format."
        end
      else
        return "Please select a file to upload."
      end      
    end
      
    # Pull fields out of the CSV into db
    def csv_to_db(encoding = "windows-1251:utf-8")
      Rails.logger.info "Starting job for #{csv_file}"
      CSV.foreach(csv_file.tempfile, :headers => true, :encoding => encoding) do |row|
        csv_row_to_db(row)
      end
      # Write a failed PID, if the process can't save to DB
    rescue => e
      Rails.logger.error "ERROR loading CSV: #{e}"
      write_pid_file(pid_failed)
    end
    private :csv_to_db
    
    def csv_row_to_db(row)
      # User can only update records he has access to
      if current_user_has_access_to_collection? row["nyu.libraries.collection"]
      
        #For each field in row, add facet to appropriate array
        row.each {|field| csv_field_to_db(field) }
      
        #Map each facet array to acts_as_taggable list 
        facets.keys.each {|facet| facets_insert.merge!({facet.to_sym => facets[facet.to_sym]}) }
        
        csv_row_save(row)
      end
    end
    
    def csv_row_save(row)
      #Generate record, or find if CSV contained a unique ID matching to original-id
      record = Umbra::Record.find_or_create_by_original_id(row["guid"])
      # Update attrs in the record and merge in facets
      # Delay with delayed_job
      record.update_attributes({
        :collection => row["nyu.libraries.collection"],
        :title => row[dc_format(:title)],
        :identifier => row[dc_format(:identifier)],
        :description => row[dc_format(:description)],
      }.merge(facets_insert))
    end
    
    def csv_field_to_db(field)
      unless field[1].nil?
        facets.keys.each do |facet|
          facets[facet.to_sym].push(field[1]) if field[0].eql? dc_format(facet)
        end
      end
    end
    
    def facets
      @facets ||= { :extent_list => [], :subject_controlled_list => [], :subject_tag_list => [], :coverage_spatial_list => [], :coverage_temporal_list => [], 
                 :coverage_jurisdiction_list => [], :source_list => [], :language_list => [], :accrualPeriodicity_list => [] }
    end
    
    def facets_insert
      @facets_insert ||= {}
    end
    
    # Get proper dublin core format from databse friendly version (i.e. subject_tag_list => dc.subject.tag)
    def dc_format(facet)
      facet.to_s.split("_list").first.split("_").unshift("dc").join(".")
    end
    private :dc_format
    
    # Verify that the CSV is actually a CSV
    def is_valid_csv
      (csv_file.content_type == "text/csv")
    end
    alias_method :is_valid_csv?, :is_valid_csv
    private :is_valid_csv
    
    # Create and write to the given PID file and folder structure
    def write_pid_file(pid_file)
      # Make temp/pids path if doesn't exist
      FileUtils.mkdir_p File.join(Rails.root, "tmp/pids")
      # Make PID file
      File.open(pid_file, 'w'){|f| f.write Process.pid}
    end
    private :write_pid_file
    
    # Delete the passed in PID file
    def delete_pid_file(pid_file)
      File.delete pid_file if File.exists? pid_file
    end
    private :delete_pid_file
    
    # Setup PID namespaced files so we know what's currently running
    def pid_namespace
      @pid_namespace ||= csv_file.original_filename.split(".")[0]
    end
    private :pid_namespace
    
    def pid_failed
      @pid_failed ||= "#{Rails.root}/tmp/pids/#{pid_namespace}_csv_failed.pid"
    end
    private :pid_failed
    
  end
end