require 'spec_helper'

describe Umbra::Collections do
  
  include Umbra::Collections
  
  let(:umbra_admin_collections) { ["global"] }
  let(:user_attributes) do 
    { 
      :umbra_admin => true, 
      :umbra_admin_collections => umbra_admin_collections
    }
  end
  let(:user) do
    User.new({
      :user_attributes => user_attributes
    })
  end
  
  describe ".current_user_admin_collections" do
    
    let(:current_user) { user }
    subject { current_user_admin_collections }

    context "when user has access to global collection" do
      it { should eql([]) }
    end
    
    context "when user collections is empty" do
      let(:umbra_admin_collections) { [] }
      it { should eql([nil]) }
    end
    
    context "when user collections is nil" do
      let(:umbra_admin_collections) { nil }
      it { should eql([nil]) }
    end
    
    context "when user has access to some non global collections" do
      let(:umbra_admin_collections) { ["vbl", "dataservices"] }
      it { should eql(["vbl", "dataservices"]) }
    end
    
    context "when user_attributes is nil" do
      let(:current_user) { User.new }
      it { should eql([nil]) }
    end
    
  end
  
  describe ".collection_selected?" do

    subject { collection_selected?("global") }
    
    context "when global is not selected" do
      it { should be_false }
    end
    
    context "when global is selected" do
      let(:params) { {:user => {:umbra_admin_collections => {:global => "1"} } }.with_indifferent_access }
      it { should be_true }
    end
    
    context "when another collection is selected and global is queried" do
      let(:params) { {:user => {:umbra_admin_collections => {:vbl => "1"} } }.with_indifferent_access }
      it { should be_false }
    end
    
    context "when another collection is selected and that collection is queried" do
      let(:params) { {:user => {:umbra_admin_collections => {:vbl => "1"} } }.with_indifferent_access }
      subject { collection_selected?("vbl") }
      it { should be_true }
    end
      
  end
  
  describe ".collection_unselected?" do

    subject { collection_unselected?("global") }
    
    context "when global is not selected" do
      it { should be_true }
    end
    
    context "when global is unselected" do
      let(:params) { {:user => {:umbra_admin_collections => {:global => "0"} } }.with_indifferent_access }
      it { should be_true }
    end
    
    context "when another collection is unselected and global is queried" do
      let(:params) { {:user => {:umbra_admin_collections => {:global => "1", :vbl => "0"} } }.with_indifferent_access }
      it { should be_false }
    end
    
    context "when another collection is unselected and that collection is queried" do
      let(:params) { {:user => {:umbra_admin_collections => {:vbl => "0"} } }.with_indifferent_access }
      subject { collection_unselected?("vbl") }
      it { should be_true }
    end
      
  end
  
end
