require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end

  test "should get email" do
    get :email
    assert_response :success
  end

  test "should get homepage" do
    get :homepage
    assert_response :success
  end

  test "should get settings" do
    get :settings
    assert_response :success
  end

  test "should get timeline" do
    get :timeline
    assert_response :success
  end

end
