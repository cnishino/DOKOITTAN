require "test_helper"

class Public::PostLocationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_post_locations_index_url
    assert_response :success
  end

  test "should get create" do
    get public_post_locations_create_url
    assert_response :success
  end

  test "should get show" do
    get public_post_locations_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_post_locations_edit_url
    assert_response :success
  end

  test "should get update" do
    get public_post_locations_update_url
    assert_response :success
  end

  test "should get destroy" do
    get public_post_locations_destroy_url
    assert_response :success
  end
end
