require 'test_helper'

class MusiciansControllerTest < ActionController::TestCase
  setup do
    @musician = musicians(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:musicians)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create musician" do
    assert_difference('Musician.count') do
      post :create, musician: {  }
    end

    assert_redirected_to musician_path(assigns(:musician))
  end

  test "should show musician" do
    get :show, id: @musician
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @musician
    assert_response :success
  end

  test "should update musician" do
    patch :update, id: @musician, musician: {  }
    assert_redirected_to musician_path(assigns(:musician))
  end

  test "should destroy musician" do
    assert_difference('Musician.count', -1) do
      delete :destroy, id: @musician
    end

    assert_redirected_to musicians_path
  end
end
