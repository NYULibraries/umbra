require 'spec_helper'

describe RecordHelper do

  include RecordHelper

  describe ".subject_controlled_list" do
    
    subject(:record) { create!(:record_with_subject_controlleds) }
    
    xit {
      expect(subject_controlled_list).to eql("") 
    }
    
  end

end
