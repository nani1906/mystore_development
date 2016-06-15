require 'test_helper'

class Admin::SlidersControllerTest < ActionController::TestCase
  setup do
    @admin_slider = admin_sliders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_sliders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_slider" do
    assert_difference('Admin::Slider.count') do
      post :create, admin_slider: {  }
    end

    assert_redirected_to admin_slider_path(assigns(:admin_slider))
  end

  test "should show admin_slider" do
    get :show, id: @admin_slider
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_slider
    assert_response :success
  end

  test "should update admin_slider" do
    patch :update, id: @admin_slider, admin_slider: {  }
    assert_redirected_to admin_slider_path(assigns(:admin_slider))
  end

  test "should destroy admin_slider" do
    assert_difference('Admin::Slider.count', -1) do
      delete :destroy, id: @admin_slider
    end

    assert_redirected_to admin_sliders_path
  end
end
