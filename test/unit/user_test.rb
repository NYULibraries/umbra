require 'test_helper'

class UserTest < ActiveSupport::TestCase

  setup :activate_authlogic

  test "user search" do
    assert_not_empty User.with_query("Marcus T")
    assert_not_empty User.with_query("Admin")
    assert_not_empty User.with_query("admin")
    assert_empty User.with_query("noemail@university.edu")
  end

end
