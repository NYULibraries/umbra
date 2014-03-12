require 'spec_helper'

describe RecordsController, :type => :controller do
  
  include Umbra::Collections
  
  let(:user) { create(:user_with_admin_collections) }
  before(:each) { controller.stub!(:current_user).and_return(user) }

  describe ".upload", vcr: { cassette_name: "upload csv document" } do
    it "should upload a CSV doc" do
      post :upload, :csv => csv_fixture("csv_sample.csv")
      expect(response).to be_successful
      expect(response).to render_template(:index)
    end
  end
  
  describe ".index", vcr: { cassette_name: "search solr records" } do    
    it "should retrieve the index of records" do
      get :index
      expect(assigns(:records)).to be_instance_of(Sunspot::Search::StandardSearch)
      expect(response).to render_template(:index)
    end
  end

end
