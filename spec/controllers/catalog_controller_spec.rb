require 'spec_helper'
describe CatalogController do

  before(:all) do
    create(:dss_record)
    create(:vbl_record)
    Umbra::Record.reindex
    sleep 10
  end

  describe "GET root" do
    before {  get :index, collection: "vbl" }
    subject { response }
    it("should have a 200 status") { expect(subject.status).to be(200) }
  end

  describe "GET /index" do
    before(:each) { @request.cookies["_check_passive_login"] = true }
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
    it "should get some search results when searching on DataServices collection" do
      get :index, q: "", collection: "dataservices", search_field: "all_fields"
      expect(assigns_response.docs.size).to be > 0
    end
  end

  def assigns_response
    @controller.instance_variable_get("@response")
  end

end
