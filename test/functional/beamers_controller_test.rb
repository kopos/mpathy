require File.dirname(__FILE__) + '/../test_helper'

class BeamersControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:beamers)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_beamer
    assert_difference('Beamer.count') do
      post :create, :beamer => { }
    end

    assert_redirected_to beamer_path(assigns(:beamer))
  end

  def test_should_show_beamer
    get :show, :id => beamers(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => beamers(:one).id
    assert_response :success
  end

  def test_should_update_beamer
    put :update, :id => beamers(:one).id, :beamer => { }
    assert_redirected_to beamer_path(assigns(:beamer))
  end

  def test_should_destroy_beamer
    assert_difference('Beamer.count', -1) do
      delete :destroy, :id => beamers(:one).id
    end

    assert_redirected_to beamers_path
  end
end
