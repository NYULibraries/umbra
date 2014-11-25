require 'spec_helper'

describe Umbra::Collections do

  include Umbra::Collections

  let(:admin_collections) { ["global"] }
  let(:admin) { true }
  let(:user) { User.new(admin: admin, admin_collections: admin_collections) }

  describe ".current_user_admin_collections" do

    let(:current_user) { user }
    subject { current_user_admin_collections }

    context "when user has access to global collection" do
      it { should eql([]) }
    end

    context "when user collections is empty" do
      let(:admin_collections) { [] }
      it { should eql([nil]) }
    end

    context "when user collections is nil" do
      let(:admin_collections) { nil }
      it { should eql([nil]) }
    end

    context "when user has access to some non global collections" do
      let(:admin_collections) { ["vbl", "dataservices"] }
      it { should eql(["vbl", "dataservices"]) }
    end

    context "when admin_collections is nil" do
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

  describe ".collection_name" do

    subject { collection_name }
    let(:session) { { :collection => :sv } }
    let(:params) { { :collection => :tt } }
    let(:repository_info) { { :repositories => { :tt => {:display => "Tiny Town", :admin_code => :tt}, :sv => {:display => "Smurf Village", :admin_code => :sv} } }.with_indifferent_access }
    let(:repositories_info) { {"Catalog" => repository_info} }

    context "when session defines collection" do
      it { should eql("Smurf Village") }
    end

    context "when params defines collection" do
      let(:session) { {} }
      it { should eql("Tiny Town") }
    end

    context "when collection is not defined" do
      let(:session) { {} }
      let(:params) { {} }
      it { should eql("") }
    end
  end

end
