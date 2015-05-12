require 'spec_helper'
describe CatalogController do

  let!(:dss_record) { create(:dss_record) }
  let!(:vbl_record) { create(:vbl_record) }


  describe "GET root" do
    context 'when _check_passive_login cookie has been set' do
      before { @request.cookies["_check_passive_login"] = true }
      before {  get :index, collection: "vbl" }
      subject { response }
      it("should have a 200 status") { expect(subject.status).to be(200) }
    end
    context 'when _check_passive_login cookie has not been set' do
      before {  get :index, collection: "vbl" }
      subject { response }
      it("should have a 302 status") { expect(subject.status).to be(302) }
      it { should redirect_to("#{ENV['PASSIVE_LOGIN_URL']}?login_url=#{request.base_url}#{login_path}&return_uri=#{request.url}") }
      it("should set _check_passive_login cookie") { expect(subject.cookies["_check_passive_login"]).to be_true }
    end
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
    xit "should get some search results when searching on DataServices collection" do
      get :index, q: "", collection: "dataservices", search_field: "all_fields"
      expect(assigns_response.docs.size).to be > 0
    end
  end

  def assigns_response
    @controller.instance_variable_get("@response")
  end

end
