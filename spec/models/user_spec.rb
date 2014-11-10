require 'spec_helper'

describe User do

  let(:user) { create(:non_admin) }

  describe "#user_collections" do

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

  describe "#has_admin_collections?" do
    subject { user.has_admin_collections? }

    context "when user is an admin" do
      let(:user) { create(:user_with_admin_collections) }
      context "and user has admin collections" do
        it { should be_true }
      end
      context "and user doesn't have admin collections" do
        let(:user) { create(:user_without_admin_collections) }
        it { should be_false }
      end
    end
    context "when user is a non admin" do
      context "and user has admin collections" do
        let(:user) { create(:non_admin, user_attributes: {umbra_admin_collections: ["VBL"],umbra_admin: false}) }
        it { should be_true }
      end
      context "and user doesn't have admin collections" do
        let(:user) { create(:non_admin, user_attributes: {umbra_admin_collections: [],umbra_admin: false}) }
        it { should be_false }
      end
    end
    context "when user doesn't have user attributes" do
      let(:user) { create(:non_admin, user_attributes: {}) }
      it { should be_false }
    end
  end

  describe "#has_global_collection?" do
    subject { user.has_global_collection? }
    context "when user has global collection" do
      let(:user) { create(:user_with_non_array_admin_collections) }
      it { should be_true }
    end
    context "when user doesn't have global collection" do
      let(:user) { create(:user_with_admin_collections) }
      it { should be_false }
    end
  end

  describe "#admin?" do
    subject { user.admin? }
    context "when user is an admin" do
      let(:user) { create(:user_with_admin_collections) }
      it { should be_true }
    end
    context "when user is not an admin" do
      let(:user) { create(:non_admin) }
      it { should be_false }
    end
    context "when user doesn't have user attributes" do
      let(:user) { create(:non_admin, user_attributes: {}) }
      it { should be_false }
    end
  end

  describe "#admin_collections_name" do
    subject { user.admin_collections_name }
    it { should eql :umbra_admin_collections }
  end

end
