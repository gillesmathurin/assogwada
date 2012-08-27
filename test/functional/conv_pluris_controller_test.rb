# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'
require 'conv_pluris_controller'

# Re-raise errors caught by the controller.
class ConvPlurisController; def rescue_action(e) raise e end; end

class ConvPlurisControllerTest < Test::Unit::TestCase
  fixtures :conv_pluris, :associations, :orgahabs

  def setup
    @controller = ConvPlurisController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:conv_pluris)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_conv_pluri
    old_count = ConvPluri.count
    post :create, :orgahab => orgahabs(:one), :association_id => associations(:one),
     :conv_pluri => { }
    assert_equal old_count+1, ConvPluri.count
    
    assert_redirected_to association_conv_pluri_path(associations(:one), assigns(:conv_pluri))
  end

  def test_should_show_conv_pluri
    get :show, :id => 1, :association_id => associations(:one)
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_conv_pluri
    put :update, :id => 1, :association_id => associations(:one),
     :orgahab => {:nom => "" },
     :conv_pluri => { }
    assert_redirected_to conv_pluri_path(assigns(:conv_pluri))
    
    put :update, :id => 1, :association_id => associations(:one),
     :orgahab => {:nom => "string" },
     :conv_pluri => { }
    assert_redirected_to conv_pluri_path(assigns(:conv_pluri))
  end
  
  def test_should_destroy_conv_pluri
    old_count = ConvPluri.count
    delete :destroy, :id => 1, :association_id => associations(:one)
    assert_equal old_count-1, ConvPluri.count
    
    assert_redirected_to association_conv_pluris_path(associations(:one))
  end
end
