require 'test_helper'

class SubtitlesControllerTest < ActionController::TestCase
  setup do
    @subtitle = subtitles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subtitles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create subtitle" do
    assert_difference('Subtitle.count') do
      post :create, :subtitle => @subtitle.attributes
    end

    assert_redirected_to subtitle_path(assigns(:subtitle))
  end

  test "should show subtitle" do
    get :show, :id => @subtitle.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @subtitle.to_param
    assert_response :success
  end

  test "should update subtitle" do
    put :update, :id => @subtitle.to_param, :subtitle => @subtitle.attributes
    assert_redirected_to subtitle_path(assigns(:subtitle))
  end

  test "should destroy subtitle" do
    assert_difference('Subtitle.count', -1) do
      delete :destroy, :id => @subtitle.to_param
    end

    assert_redirected_to subtitles_path
  end
end
