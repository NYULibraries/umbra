##
## Class for handling batch uploads from CSV
##
## TODO: This is way too confusing method of adding facets from CSV; Document!
##
require 'csv'
module Umbra
  class CsvUpload
    include Umbra::Collections
    attr_accessor :csv_file, :current_user, :encoding

    def initialize(csv_file, current_user, encoding = "windows-1251:utf-8")
      unless csv_file.present?
        raise ArgumentError.new("Please select a file to upload.")
      end
      unless csv_file.content_type == "text/csv"
        raise ArgumentError.new("File must be in CSV format.")
      end
      @csv_file = csv_file
      @current_user = current_user
      @encoding = encoding
    end

    # Pull fields out of the CSV into db
    def upload
      Rails.logger.info "Starting job for #{csv_file}"
      CSV.foreach(csv_file.tempfile, :headers => true, :encoding => encoding) do |row|
        csv_row_to_db!(row)
      end
      return true
      # Write a failed PID, if the process can't save to DB
    rescue => e
      Rails.logger.error "ERROR loading CSV: #{e}"
      write_pid_file(pid_failed)
    end

    def csv_row_to_db!(row)
      # User can only update records he has access to
      if current_user_has_access_to_collection? row["nyu.libraries.collection"]

        #For each field in row, add facet to appropriate array
        row.each {|field| csv_field_to_db(field) }

        #Map each facet array to acts_as_taggable list
        facets_insert = Hash.new
        facets.keys.each {|facet| facets_insert.merge!({facet.to_sym => facets[facet.to_sym] }) }

        csv_row_save!(row, facets_insert)
        @facets = nil
      end
    end

    def csv_row_save!(row, facets_insert)
      #Generate record, or find if CSV contained a unique ID matching to original-id
      record = Umbra::Record.find_or_initialize_by(original_id: row["guid"])
      record.collection = row["nyu.libraries.collection"]
      record.title = row[dc_format(:title)]
      record.identifier = row[dc_format(:identifier)]
      record.description = row[dc_format(:description)]
      facets_insert.each do |facet,facet_value|
        record.send("#{facet}=",facet_value)
      end
      record.save
    end

    def csv_field_to_db(field)
      unless field[1].nil?
        facets.keys.each do |facet|
          # Complex little line to avoid pushing duplicates of the same tag
          # definitely an ugly solution and going away soon
          if facet_is_current_field(facet, field) && field_is_not_in_facet(field, facet)
            facets[facet.to_sym].push(field[1])
          end
        end
      end
    end

    def facet_is_current_field(facet, field)
      field[0].eql? dc_format(facet)
    end

    def field_is_not_in_facet(field, facet)
      !facets[facet.to_sym].map{|f| f.downcase}.include?(field[1].downcase)
    end

    def facets
      @facets ||= { :extent_list => [], :subject_controlled_list => [], :subject_tag_list => [], :coverage_spatial_list => [], :coverage_temporal_list => [],
                 :coverage_jurisdiction_list => [], :source_list => [], :language_list => [], :accrualPeriodicity_list => [] }
    end

    # Get proper dublin core format from databse friendly version (i.e. subject_tag_list => dc.subject.tag)
    def dc_format(facet)
      facet.to_s.split("_list").first.split("_").unshift("dc").join(".")
    end
    private :dc_format

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
