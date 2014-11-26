require 'spec_helper'
describe CatalogController do

  let!(:dss_record) { create(:dss_record) }
  let!(:vbl_record) { create(:vbl_record) }

  describe "GET /index" do
    it "should not get search results when searching an invalid term" do
      get :index, q: "danjkdw", search_field: "all_fields"
      expect(assigns_response.docs.size).to be 0
    end
    it "should get all search results when performing an empty search" do
      get :index, q: "", search_field: "all_fields"
      expect(assigns_response.docs.size).to be > 0
    end
    it "should get some search results when searching on VBL collection" do
      get :index, q: "", collection: "vbl", search_field: "all_fields"
      expect(assigns_response.docs.size).to be > 0
    end
    xit "should get some search results when searching on DataServices collection" do
      get :index, q: "", collection: "dataservices", search_field: "all_fields"
      expect(assigns_response.docs.size).to be > 0
    end
  end

  def assigns_response
    @controller.instance_variable_get("@response")
  end

end
