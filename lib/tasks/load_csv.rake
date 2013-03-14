require 'csv'

namespace :umbra do
  desc "Import from csv file"
  task :load_csv, [:klass, :csv_file, :encoding] => :environment do |t, args|
    #, :encoding => "windows-1251:utf-8"
    args.with_defaults(:klass => "Umbra::Record", :csv_file => "db/csv/newspapers.csv")

    #For each line in CSV database file, include headers and encoding conditionally
    CSV.foreach(args[:csv_file], :headers => true, :encoding => args[:encoding]) do |row|
      #Create a hash of expected facets to add with acts_as_taggable
      facets = { :extent_list => [], :subject_controlled_list => [], :subject_tag_list => [], :coverage_spatial_list => [], :coverage_temporal_list => [], :coverage_jurisdiction_list => [], :source_list => [], :language_list => [], :accrualPeriodicity_list => [] }
      facets_insert = {}
      #For each field in row, add facet to appropriate array
      row.each do |field|
        unless field[1].nil?
          facets[:subject_controlled_list].push(field[1]) if field[0].eql? "dc.subject.controlled"
          facets[:subject_tag_list].push(field[1]) if field[0].eql? "dc.subject.tag"
          facets[:extent_list].push(field[1]) if field[0].eql? "dc.extent"
          facets[:coverage_spatial_list].push(field[1]) if field[0].eql? "dc.coverage.spatial"
          facets[:coverage_temporal_list].push(field[1]) if field[0].eql? "dc.coverage.temporal"
          facets[:coverage_jurisdiction_list].push(field[1]) if field[0].eql? "dc.coverage.jurisdiction"
          facets[:source_list].push(field[1]) if field[0].eql? "dc.source"
          facets[:language_list].push(field[1]) if field[0].eql? "dc.language"
          facets[:accrualPeriodicity_list].push(field[1]) if field[0].eql? "dc.accrualPeriodicity"
        end
      end
     
      #Map each facet array to acts_as_taggable list 
      facets.keys.each {|facet| facets_insert.merge!({facet.to_sym => facets[facet.to_sym]}) }
     
      #Generate record, or find if CSV contained a unique ID matching to original-id
      rec = args[:klass].constantize.find_or_create_by_original_id(row["guid"])
      #Update attrs in the record and merge in facets
      rec.update_attributes({
        :collection => row["nyu.libraries.collection"],
        :title => row["dc.title"],
        :identifier => row["dc.identifier"],
        :description => row["dc.description"],
      }.merge(facets_insert))
    end
  end
end
