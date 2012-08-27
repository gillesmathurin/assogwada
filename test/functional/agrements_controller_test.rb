# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'
require 'agrements_controller'

# Re-raise errors caught by the controller.
class AgrementsController; def rescue_action(e) raise e end; end

class AgrementsControllerTest < Test::Unit::TestCase
  fixtures :agrements, :associations, :orgahabs

  def setup
    @controller = AgrementsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index, :association_id => associations(:one)
    assert_response :success
    assert assigns(:agrements)
  end

  def test_should_get_new
    get :new, :association_id => associations(:one)
    assert_response :success
  end
  
  def test_should_create_agrement
    old_count = Agrement.count
    post :create, :agrement => { :nom => "string",
                      :association_id => associations(:one),
                      :orgahab_id => orgahabs(:one) },
                      :association_id => associations(:one),
                      :orgahab => orgahabs(:one)
    assert_equal old_count+1, Agrement.count
    
    assert_redirected_to association_agrement_path(associations(:one),
     assigns(:agrement))
  end

  def test_should_show_agrement
    get :show, :id => 1, :association_id => associations(:one)
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1, :association_id => associations(:one)
    assert_response :success
  end
  
  def test_should_update_agrement
    put :update, :id => 1, :agrement => { :nom => "string",
      :association_id => associations(:one),
      :orgahab_id => orgahabs(:one) },
      :association_id => associations(:one),
      :orgahab => {:nom => "" }
    assert_redirected_to association_agrement_path(associations(:one), assigns(:agrement))
    
    put :update, :id => 1, :agrement => { :nom => "string",
      :association_id => associations(:one),
      :orgahab_id => orgahabs(:one) },
      :association_id => associations(:one),
      :orgahab => {:nom => "agrement" }
    assert_redirected_to association_agrement_path(associations(:one), assigns(:agrement))
  end
  
  def test_should_destroy_agrement
    old_count = Agrement.count
    delete :destroy, :id => 1, :association_id => associations(:one)
    assert_equal old_count-1, Agrement.count
    
    assert_redirected_to association_agrements_path(associations(:one))
  end
end
