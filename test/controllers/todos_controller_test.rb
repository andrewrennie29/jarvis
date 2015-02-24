require 'test_helper'

class TodosControllerTest < ActionController::TestCase
  test "should get details" do
    get :details
    assert_response :success
  end

end
