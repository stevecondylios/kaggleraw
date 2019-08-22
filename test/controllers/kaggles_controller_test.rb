require 'test_helper'

class KagglesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get kaggles_index_url
    assert_response :success
  end

end
