# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'
require 'orgahabs_controller'

# Re-raise errors caught by the controller.
class OrgahabsController; def rescue_action(e) raise e end; end

class OrgahabsControllerTest < Test::Unit::TestCase
  fixtures :orgahabs

  def setup
    @controller = OrgahabsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:orgahabs)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_orgahab
    old_count = Orgahab.count
    post :create, :orgahab => { }
    assert_equal old_count+1, Orgahab.count
    
    assert_redirected_to orgahab_path(assigns(:orgahab))
  end

  def test_should_show_orgahab
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_orgahab
    put :update, :id => 1, :orgahab => { }
    assert_redirected_to orgahab_path(assigns(:orgahab))
  end
  
  def test_should_destroy_orgahab
    old_count = Orgahab.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Orgahab.count
    
    assert_redirected_to orgahabs_path
  end
end
