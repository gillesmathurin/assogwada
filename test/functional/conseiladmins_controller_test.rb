# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'
require 'conseiladmins_controller'

# Re-raise errors caught by the controller.
class ConseiladminsController; def rescue_action(e) raise e end; end

class ConseiladminsControllerTest < Test::Unit::TestCase
  fixtures :conseiladmins, :associations

  def setup
    @controller = ConseiladminsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index, :association_id => associations(:one)
    assert_response :success
    assert assigns(:conseiladmins)
  end

  def test_should_get_new
    get :new, :association_id => associations(:one)
    assert_response :success
  end
  
  def test_should_create_conseiladmin
    old_count = Conseiladmin.count
    post :create, :conseiladmin => { }, :association_id => associations(:one)
    assert_equal old_count+1, Conseiladmin.count
    
    assert_redirected_to association_conseiladmin_path(associations(:one),
     assigns(:conseiladmin))
  end

  def test_should_show_conseiladmin
    get :show, :id => 1, :association_id => associations(:one)
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1, :association_id => associations(:one)
    assert_response :success
  end
  
  def test_should_update_conseiladmin
    put :update, :id => 1, :conseiladmin => { }, :association_id => associations(:one)
    assert_redirected_to association_conseiladmin_path(associations(:one),
     assigns(:conseiladmin))
  end
  
  def test_should_destroy_conseiladmin
    old_count = Conseiladmin.count
    delete :destroy, :id => 1, :association_id => associations(:one)
    assert_equal old_count-1, Conseiladmin.count
    
    assert_redirected_to association_conseiladmins_path(associations(:one))
  end
end
