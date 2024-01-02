require "test_helper"

class IndexControllerTest < ActionDispatch::IntegrationTest
  test "should get landing_page" do
    get index_landing_page_url
    assert_response :success
  end
end
