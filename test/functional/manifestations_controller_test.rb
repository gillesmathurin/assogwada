# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'
require 'manifestations_controller'

# Re-raise errors caught by the controller.
class ManifestationsController; def rescue_action(e) raise e end; end

class ManifestationsControllerTest < Test::Unit::TestCase
  fixtures :manifestations, :associations

  def setup
    @controller = ManifestationsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:manifestations)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_manifestation
    old_count = Manifestation.count
    post :create, :manifestation => { }
    assert_equal old_count+1, Manifestation.count
    
    assert_redirected_to manifestation_path(assigns(:manifestation))
  end

  def test_should_show_manifestation
    get :show, :id => 1, :association_id => associations(:one)
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_manifestation
    put :update, :id => 1, :association_id => associations(:one), :manifestation => { }
    assert_redirected_to association_path(associations(:one))
    # assert_redirected_to association_manifestation_path(associations(:one), 
    # assigns(:manifestation))
  end
  
  def test_should_destroy_manifestation
    old_count = Manifestation.count
    delete :destroy, :id => 1, :association_id => associations(:one)
    assert_equal old_count-1, Manifestation.count
    
    assert_redirected_to manifestations_path
  end
end
