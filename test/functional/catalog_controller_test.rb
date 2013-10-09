require 'test_helper'

class CatalogControllerTest < ActionController::TestCase
  
  setup do
    activate_authlogic
    # Pretend we've already checked PDS/Shibboleth for the session
    # and we have a session
    @request.cookies[:attempted_sso] = { value: "true" }
    @controller.session[:session_id] = "FakeSessionID"
  end
  
  test "should search indexed records and get a result" do
     VCR.use_cassette('blacklight search query', :match_requests_on => [:body]) do
       post :index, :q => "dateline"
     end
     assert_template :index
  end
  
  test "empty search should get a result" do
     VCR.use_cassette('blacklight search blank', :match_requests_on => [:body]) do
       post :index, :q => ""
     end
     assert_template :index
  end
  
end
