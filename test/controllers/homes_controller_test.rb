require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  setup do
    @home = home(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:home)
  end

end
