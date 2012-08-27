# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'
require 'locals_controller'

# Re-raise errors caught by the controller.
class LocalsController; def rescue_action(e) raise e end; end

class LocalsControllerTest < Test::Unit::TestCase
  fixtures :locals, :associations

  def setup
    @controller = LocalsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index, :association_id => associations(:one)
    assert_response :success
    assert assigns(:locals)
  end

  def test_should_get_new
    get :new, :association_id => associations(:one)
    assert_response :success
  end
  
  def test_should_create_local
    old_count = Local.count
    post :create, :local => { }, :association_id => associations(:one)
    assert_equal old_count+1, Local.count
    
    assert_redirected_to association_local_path(associations(:one), assigns(:local))
  end

  def test_should_show_local
    get :show, :id => 1, :association_id => associations(:one)
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1, :association_id => associations(:one)
    assert_response :success
  end
  
  def test_should_update_local
    put :update, :id => 1, :association_id => associations(:one), :local => { }
    assert_redirected_to association_local_path(associations(:one), assigns(:local))
  end
  
  def test_should_destroy_local
    old_count = Local.count
    delete :destroy, :id => 1, :association_id => associations(:one)
    assert_equal old_count-1, Local.count
    
    assert_redirected_to association_locals_path(associations(:one))
  end
end
