require "test_helper"

class Admin::TargetAgesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_target_ages_index_url
    assert_response :success
  end
end
