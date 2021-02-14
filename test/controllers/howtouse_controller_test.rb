require 'test_helper'

class HowtouseControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get howtouse_index_url
    assert_response :success
  end

end
