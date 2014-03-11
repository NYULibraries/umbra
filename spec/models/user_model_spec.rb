require 'spec_helper'

describe User do
  
  describe ".user_collections" do
    
    subject { user.user_collections }

    context "when user has admin collections in array" do
      let(:user) { create(:user_with_admin_collections) }
      it { should be_instance_of(Array) }
      it { should eql(["VBL", "DataServices"]) }
    end
    
    context "when user has admin collections in string" do
      let(:user) { create(:user_with_non_array_admin_collections) }
      it { should be_instance_of(Array) }
      it { should eql(["global"]) }
    end
    
    context "when user doesn't have admin collections" do
      let(:user) { create(:user_without_admin_collections) }
      it { should be_instance_of(Array) }
      it { should eql([]) }
    end
  end
  
end
