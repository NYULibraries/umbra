require 'spec_helper'

describe UsersController do

  include Umbra::Collections

  let(:user) { create(:user_with_admin_collections) }
  let(:non_admin) { create(:non_admin) }
  before(:each) { @request.cookies["_check_passive_login"] = true }
  before(:each) { controller.stub(:current_user).and_return(user) }

  describe "GET index" do
    it "should retrieve the index of users" do
      get :index
      expect(assigns(:users)).to_not be_nil
      expect(response).to render_template(:index)
    end
    it "should retrieve the index of users as CSV" do
      get :index, format: :csv
      expect(assigns(:users)).to_not be_nil
    end
  end

  describe "GET show" do
    it "should get the show page of a user" do
      get :show, id: user
      expect(assigns(:user)).to_not be_nil
      expect(response).to render_template(:show)
    end
  end

  describe "PATCH update" do
    it "should update a user with new collections" do
      patch :update, id: non_admin, user: { "umbra_admin_collections"=>{ "VBL"=>"1", "DataServices"=>"0", "global"=>"1" } }
      expect(assigns(:user).user_collections).to eql ["VBL","global"]
      expect(assigns(:user).admin?).to be_true
    end
  end

  describe "DELETE destroy" do
    let!(:non_admin) { create(:non_admin) }
    it "should delete a user" do
      expect{ delete :destroy, id: non_admin }.to change(User, :count).by(-1)
    end
  end

  describe "DELETE clear_patron_data" do
    let!(:non_admin) { create(:non_admin) }
    let!(:non_admin1) { create(:non_admin) }
    let!(:admin) { create(:user_with_admin_collections) }
    it "should delete all non admins" do
      expect{ delete :clear_patron_data }.to change(User, :count).by(-2)
    end
  end

  describe "#sort_column" do
    subject { controller.sort_column }
    it { should eql "lastname" }
  end

end
