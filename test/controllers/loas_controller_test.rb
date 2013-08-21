require 'test_helper'

class LoasControllerTest < ActionController::TestCase
  setup do
    @loa = loas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:loas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create loa" do
    assert_difference('Loa.count') do
      post :create, loa: { city: @loa.city, profile_id: @loa.profile_id, street: @loa.street, subject: @loa.subject, to: @loa.to, what: @loa.what, zip: @loa.zip }
    end

    assert_redirected_to loa_path(assigns(:loa))
  end

  test "should show loa" do
    get :show, id: @loa
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @loa
    assert_response :success
  end

  test "should update loa" do
    patch :update, id: @loa, loa: { city: @loa.city, profile_id: @loa.profile_id, street: @loa.street, subject: @loa.subject, to: @loa.to, what: @loa.what, zip: @loa.zip }
    assert_redirected_to loa_path(assigns(:loa))
  end

  test "should destroy loa" do
    assert_difference('Loa.count', -1) do
      delete :destroy, id: @loa
    end

    assert_redirected_to loas_path
  end
end
