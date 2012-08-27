# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'
require 'besoin_materiels_controller'

# Re-raise errors caught by the controller.
class BesoinMaterielsController; def rescue_action(e) raise e end; end

class BesoinMaterielsControllerTest < Test::Unit::TestCase
  fixtures :besoin_materiels, :associations

  def setup
    @controller = BesoinMaterielsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index, :association_id => associations(:two)
    assert_response :success
    assert assigns(:besoin_materiels)
  end

  def test_should_get_new
    get :new, :association_id => associations(:two)
    assert_response :success
  end
  
  def test_should_create_besoin_materiel
    old_count = BesoinMateriel.count
    post :create, :besoin_materiel => { }, :association_id => associations(:two)
    assert_equal old_count+1, BesoinMateriel.count
    
    assert_redirected_to association_besoin_materiel_path(associations(:two),
     assigns(:besoin_materiel))
  end

  def test_should_show_besoin_materiel
    get :show, :id => 1, :association_id => associations(:two)
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1, :association_id => associations(:two)
    assert_response :success
  end
  
  def test_should_update_besoin_materiel
    put :update, :id => 1, :besoin_materiel => { }, :association_id => associations(:two)
    assert_redirected_to association_besoin_materiel_path(associations(:two), 
    assigns(:besoin_materiel))
  end
  
  def test_should_destroy_besoin_materiel
    old_count = BesoinMateriel.count
    delete :destroy, :id => 1, :association_id => associations(:two)
    assert_equal old_count-1, BesoinMateriel.count
    
    assert_redirected_to association_besoin_materiels_path(associations(:two))
  end
end
