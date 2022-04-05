require "test_helper"

class Admin::PrefecturesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_prefectures_index_url
    assert_response :success
  end

  test "should get create" do
    get admin_prefectures_create_url
    assert_response :success
  end

  test "should get edit" do
    get admin_prefectures_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_prefectures_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_prefectures_destroy_url
    assert_response :success
  end
end
