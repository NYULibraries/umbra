require 'spec_helper'

describe RecordsController, :type => :controller do

  include Umbra::Collections

  let(:user) { create(:user_with_admin_collections) }
  let(:record) { create(:record) }
  before(:each) { @request.cookies["_check_passive_login"] = true }
  before(:each) { controller.stub(:current_user).and_return(user) }

  describe "GET index" do
    it "should retrieve the index of records" do
      get :index
      expect(assigns(:records)).to be_instance_of(Sunspot::Search::StandardSearch)
      expect(response).to render_template(:index)
    end
  end

  describe "GET show" do
    it "should get the show page of a record" do
      get :show, id: record
      expect(assigns(:record)).to be_instance_of Umbra::Record
      expect(assigns(:record).title).to eql "MyRecord"
      expect(response).to render_template(:show)
    end
  end

  describe "GET new" do
    it "should show the new record page" do
      get :new
      expect(assigns(:record)).to be_instance_of Umbra::Record
      expect(assigns(:record)).to be_new_record
      expect(response).to render_template(:new)
    end
  end

  describe "GET edit" do
    it "should show the edit record page" do
      get :edit, id: record
      expect(assigns(:record)).to be_instance_of Umbra::Record
      expect(assigns(:record).title).to eql "MyRecord"
      expect(response).to render_template(:edit)
    end
  end

  describe "POST create" do
    it "should create a new record" do
      post :create, record: { title: "A Dull Old World", collection: "Ye Olde Book Shoppe" }
      expect(assigns(:record)).to_not be_nil
      expect(assigns(:record)).to be_instance_of Umbra::Record
    end
  end

  describe "PATCH update" do
    it "should update a record" do
      patch :update, id: record, record: { title: "A Brave New World" }
      expect(assigns(:record).title).to eql "A Brave New World"
    end
  end

  describe "DELETE destroy" do
    let!(:record) { create(:record) }
    it "should delete a record" do
      expect{ delete :destroy, id: record }.to change(Umbra::Record, :count).by(-1)
    end
  end

  describe "PATCH upload" do
    subject { patch :upload, csv: csv_file }
    context "when csv is valid" do
      let(:csv_file) { csv_fixture("csv_sample.csv") }
      it "should upload a CSV doc" do
        expect(subject).to be_successful
        expect(subject).to render_template(:index)
        expect( subject.request.flash[:success] ).to_not be_nil
      end
    end
    context "when csv is missing" do
      let(:csv_file) { "" }
      it "should complain about a missing CSV file" do
        expect( subject.request.flash[:error] ).to_not be_nil
      end
    end
    context "when csv is an invalid content type" do
      let(:csv_file) { csv_fixture("csv_sample.csv", "evil/virus") }
      it "should complain about an invalid content type" do
        expect( subject.request.flash[:error] ).to_not be_nil
      end
    end
  end

  describe "#sort_column" do
    subject { controller.sort_column }
    it { should eql "title_sort" }
  end

end
