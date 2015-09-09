module Umbra
  class Record < ActiveRecord::Base

    # This hack forces @record instance variable routes not to prepend umbra_
    def self.model_name
      ActiveModel::Name.new("Umbra::Record", nil, "Record")
    end

    # Include facets functions here
    include Umbra::Facets

    validates_presence_of :collection, :title

    RECORD_ATTRIBUTES = [:collection, :description, :identifier, :record_attributes, :title, :original_id]

    # Facets use Dublin Core naming scheme
    add_facets :extent, :coverage_spatial, :coverage_temporal, :coverage_jurisdiction,
               :source, :language, :accrualPeriodicity, :subject_controlled, :subject_tag

    # Creat attr accessors for each facet list
    facets_accessible.each do |facet|
      RECORD_ATTRIBUTES << facet
    end

    # Make each facet set taggable
    facets_taggable.each do |facet|
      acts_as_taggable_on facet
    end

    searchable :auto_index => :index? do
      text :title, :boost => 5.0, :stored => true
      text :description, :stored => true
      text :collection, :stored => true
      string :resource_id, :stored => true do
        to_param
      end
      string :title_sort, :stored => true do
        title
      end
      string :collection, :stored => true
      string :identifier, :stored => true
      # Usee the
      facets_accessible.each do |facet|
        string facet.to_sym, :multiple => true, :stored => true
      end
    end

    # Always auto_index for now
    # Could insert logic here for when to auto_index
    def index?
      true
    end

  end
end
