require 'test_helper'

class DeviceBlocksControllerTest < ActionController::TestCase
  setup do
    @device_block = device_blocks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:device_blocks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create device_block" do
    assert_difference('DeviceBlock.count') do
      post :create, device_block: {  }
    end

    assert_redirected_to device_block_path(assigns(:device_block))
  end

  test "should show device_block" do
    get :show, id: @device_block
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @device_block
    assert_response :success
  end

  test "should update device_block" do
    put :update, id: @device_block, device_block: {  }
    assert_redirected_to device_block_path(assigns(:device_block))
  end

  test "should destroy device_block" do
    assert_difference('DeviceBlock.count', -1) do
      delete :destroy, id: @device_block
    end

    assert_redirected_to device_blocks_path
  end
end
