require File.dirname(__FILE__) + '/../test_helper'

class ZonesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:zones)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_zone
    assert_difference('Zone.count') do
      post :create, :zone => { }
    end

    assert_redirected_to zone_path(assigns(:zone))
  end

  def test_should_show_zone
    get :show, :id => zones(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => zones(:one).id
    assert_response :success
  end

  def test_should_update_zone
    put :update, :id => zones(:one).id, :zone => { }
    assert_redirected_to zone_path(assigns(:zone))
  end

  def test_should_destroy_zone
    assert_difference('Zone.count', -1) do
      delete :destroy, :id => zones(:one).id
    end

    assert_redirected_to zones_path
  end
end
