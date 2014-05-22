require 'spec_helper'

describe RecordHelper do

  include RecordHelper

  let(:facets) { subject.map(&:name) }

  describe ".subject_controlled_list", vcr: { cassette_name: "subject controlled facets" } do
    before { create(:record_with_subject_controlled_list) }
    subject { subject_controlled_list }
    it { should be_instance_of(Array) }
    it { expect(subject.count).to eql(2) }
    it { expect(subject.first.class).to be(ActsAsTaggableOn::Tag) }
    it { expect(facets).to include 'SubjectControlled 1' }
  end

  describe ".extent_list", vcr: { cassette_name: "extent facets" } do
    before { create(:record_with_extent_list) }
    subject { extent_list }
    it { should be_instance_of(Array) }
    it { expect(subject.count).to eql(2) }
    it { expect(subject.first.class).to be(ActsAsTaggableOn::Tag) }
    it { expect(facets).to include 'Extent 1' }
  end

  describe ".coverage_spatial_list", vcr: { cassette_name: "coverage spatial facets" } do
    before { create(:record_with_coverage_spatial_list) }
    subject { coverage_spatial_list }
    it { should be_instance_of(Array) }
    it { expect(subject.count).to eql(1) }
    it { expect(subject.first.class).to be(ActsAsTaggableOn::Tag) }
    it { expect(facets).to include 'CoverageSpatial 1' }
  end

  describe ".coverage_temporal_list", vcr: { cassette_name: "coverage temporal facets" } do
    before { create(:record_with_coverage_temporal_list) }
    subject { coverage_temporal_list }
    it { should be_instance_of(Array) }
    it { expect(subject.count).to eql(1) }
    it { expect(subject.first.class).to be(ActsAsTaggableOn::Tag) }
    it { expect(facets).to include 'CoverageTemporal 1' }
  end

  describe ".coverage_jurisdiction_list", vcr: { cassette_name: "coverage jurisdiction facets" } do
    before { create(:record_with_coverage_jurisdiction_list) }
    subject { coverage_jurisdiction_list }
    it { should be_instance_of(Array) }
    it { expect(subject.count).to eql(1) }
    it { expect(subject.first.class).to be(ActsAsTaggableOn::Tag) }
    it { expect(facets).to include 'CoverageJurisdiction 1' }
  end

  describe ".source_list", vcr: { cassette_name: "source facets" } do
    before { create(:record_with_source_list) }
    subject { source_list }
    it { should be_instance_of(Array) }
    it { expect(subject.count).to eql(2) }
    it { expect(subject.first.class).to be(ActsAsTaggableOn::Tag) }
    it { expect(facets).to include 'Source 1' }
  end

  describe ".language_list", vcr: { cassette_name: "language facets" } do
    before { create(:record_with_language_list) }
    subject { language_list }
    it { should be_instance_of(Array) }
    it { expect(subject.count).to eql(3) }
    it { expect(subject.first.class).to be(ActsAsTaggableOn::Tag) }
    it { expect(facets).to include 'Language 1' }
  end

  describe ".accrualPeriodicity_list", vcr: { cassette_name: "accrualPeriodicity facets" } do
    before { create(:record_with_accrualPeriodicity_list) }
    subject { accrualPeriodicity_list }
    it { should be_instance_of(Array) }
    it { expect(subject.count).to eql(1) }
    it { expect(subject.first.class).to be(ActsAsTaggableOn::Tag) }
    it { expect(facets).to include 'AccrualPeriodicity 1' }
  end

  describe ".subject_tag_list", vcr: { cassette_name: "subject tag facets" } do
    before { create(:record_with_subject_tag_list) }
    subject { subject_tag_list }
    it { should be_instance_of(Array) }
    it { expect(subject.count).to eql(3) }
    it { expect(subject.first.class).to be(ActsAsTaggableOn::Tag) }
    it { expect(facets).to include 'SubjectTag 1' }
  end

end
