require 'test_helper'

class RecordsControllerTest < ActionController::TestCase
  setup :activate_authlogic
    
  setup do
    current_user = UserSession.create(users(:global_admin))
    @record = records(:one)
  end

  test "should get index" do
    VCR.use_cassette('records index', :match_requests_on => [:path]) do
      get :index
      assert_response :success
      assert_not_nil assigns(:records)
    end
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create record" do
    VCR.use_cassette('record create', :match_requests_on => [:path]) do
      assert_difference('Umbra::Record.count') do
        post :create, record: { collection: @record.collection, description: @record.description, identifier: @record.identifier, record_attributes: @record.record_attributes, title: @record.title }
      end

      assert_redirected_to record_path(assigns(:record))
    end
  end

  test "should show record" do
    get :show, id: @record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @record
    assert_response :success
  end

  test "should update record" do
    VCR.use_cassette('record update', :match_requests_on => [:path]) do
      put :update, id: @record, record: { collection: @record.collection, description: @record.description, identifier: @record.identifier, record_attributes: @record.record_attributes, title: @record.title }
      assert_redirected_to record_path(assigns(:record))
    end
  end

  test "should destroy record" do
    VCR.use_cassette('record destory', :match_requests_on => [:path]) do
      assert_difference('Umbra::Record.count', -1) do
        delete :destroy, id: @record
      end

      assert_redirected_to records_path
    end
  end
end
