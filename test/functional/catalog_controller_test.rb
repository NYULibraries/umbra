require 'test_helper'

class CatalogControllerTest < ActionController::TestCase
  
  setup :activate_authlogic

  def setup
   current_user = UserSession.create(users(:global_admin))
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
