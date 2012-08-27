# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'
require 'dispositifs_controller'

# Re-raise errors caught by the controller.
class DispositifsController; def rescue_action(e) raise e end; end

class DispositifsControllerTest < Test::Unit::TestCase
  fixtures :dispositifs, :associations

  def setup
    @controller = DispositifsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index, :association_id => associations(:one)
    assert_response :success
    assert assigns(:dispositifs)
  end

  def test_should_get_new
    get :new, :association_id => associations(:one)
    assert_response :success
  end
  
  def test_should_create_dispositif
    old_count = Dispositif.count
    post :create, :dispositif => { }
    assert_equal old_count+1, Dispositif.count
    
    assert_redirected_to dispositif_path(assigns(:dispositif))
  end

  def test_should_show_dispositif
    get :show, :id => 1, :association_id => associations(:one)
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1, :association_id => associations(:one)
    assert_response :success
  end
  
  def test_should_update_dispositif
    put :update, :id => 1, :dispositif => { }, :association_id => associations(:one)
    assert_redirected_to dispositif_path(assigns(:dispositif))
  end
  
  def test_should_destroy_dispositif
    old_count = Dispositif.count
    delete :destroy, :id => 1, :association_id => associations(:one)
    assert_equal old_count-1, Dispositif.count
    
    assert_redirected_to dispositifs_path
  end
end
