require 'spec_helper'

describe RecordHelper do

  include RecordHelper

  describe ".subject_controlled_list" do   
    subject(:record) { create(:record_with_subject_controlled_list) }   
    it { expect(subject_controlled_list).to eql([]) }
  end
  
  describe ".extent_list" do   
    subject(:record) { create(:record_with_extent_list) }   
    it { expect(extent_list).to eql([]) }
  end
  
  describe ".coverage_spatial_list" do   
    subject(:record) { create(:record_with_coverage_spatial_list) }   
    it { expect(coverage_spatial_list).to eql([]) }
  end
  
  describe ".coverage_temporal_list" do   
    subject(:record) { create(:record_with_subject_controlled_list) }   
    it { expect(coverage_temporal_list).to eql([]) }
  end
  
  describe ".coverage_jurisdiction_list" do   
    subject(:record) { create(:record_with_coverage_jurisdiction_list) }   
    it { expect(coverage_jurisdiction_list).to eql([]) }
  end
  
  describe ".source_list" do   
    subject(:record) { create(:record_with_source_list) }   
    it { expect(source_list).to eql([]) }
  end
  
  describe ".language_list" do   
    subject(:record) { create(:record_with_language_list) }   
    it { expect(language_list).to eql([]) }
  end
  
  describe ".accrualPeriodicity_list" do   
    subject(:record) { create(:record_with_accrualPeriodicity_list) }   
    it { expect(accrualPeriodicity_list).to eql([]) }
  end
  
  describe ".subject_tag_list" do   
    subject(:record) { create(:record_with_subject_tag_list) }   
    it { expect(subject_tag_list).to eql([]) }
  end

end
