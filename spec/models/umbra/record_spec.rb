require 'spec_helper'

describe Umbra::Record do

  let(:record) { Umbra::Record.new }

  describe "#index?" do
    subject { record.index? }
    it { should be_true }
  end

  describe ".model_name" do
    subject { Umbra::Record.model_name }
    it { should be_instance_of ActiveModel::Name }
  end

  describe "Umbra::Facets" do

    before(:all) { Umbra::Record.add_facets(:new_facet, :new_facet_2) }

    describe ".facets" do
      subject { Umbra::Record.facets }
      it { should eql [:extent, :coverage_spatial, :coverage_temporal, :coverage_jurisdiction, :source, :language, :accrualPeriodicity, :subject_controlled, :subject_tag, :new_facet, :new_facet_2] }
    end

    describe ".facets_accessible" do
      subject { Umbra::Record.facets_accessible }
      it { should eql [:extent_list, :coverage_spatial_list, :coverage_temporal_list, :coverage_jurisdiction_list, :source_list, :language_list, :accrualPeriodicity_list, :subject_controlled_list, :subject_tag_list, :new_facet_list, :new_facet_2_list] }
    end

    describe ".facets_taggable" do
      subject { Umbra::Record.facets_taggable }
      it { should eql [:extents, :coverage_spatials, :coverage_temporals, :coverage_jurisdictions, :sources, :languages, :accrualPeriodicities, :subject_controlleds, :subject_tags, :new_facets, :new_facet_2s] }
    end

  end

end
