require "test_helper"

class Admin::PostLocationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_post_locations_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_post_locations_show_url
    assert_response :success
  end
end
