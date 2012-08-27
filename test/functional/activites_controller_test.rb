# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'
require 'activites_controller'

# Re-raise errors caught by the controller.
class ActivitesController; def rescue_action(e) raise e end; end

class ActivitesControllerTest < Test::Unit::TestCase
  fixtures :activites, :associations

  def setup
    @controller = ActivitesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index, :association_id => associations(:one)
    assert_response :success
    assert assigns(:activites)
  end

  def test_should_get_new
    get :new, :association_id => associations(:one)
    assert_response :success
  end
  
  def test_should_create_activite
    old_count = Activite.count
    post :create, :association_id => associations(:one),
     :activite => {:nom => "nom",
      :tarif_mensuel => 25,
      :modalite_inscription => "text",
      :info_supp => "text",
      :spectateur => "adulte",
      :besoin_habilitation => false }
    assert_equal old_count+1, Activite.count
    
    assert_redirected_to association_activite_path(associations(:one), assigns(:activite))
  end

  def test_should_show_activite
    get :show, :id => 1, :association_id => associations(:one)
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1, :association_id => associations(:one)
    assert_response :success
  end
  
  def test_should_update_activite
    put :update, :id => 1, :activite => { }, :association_id => associations(:one)
    assert_redirected_to association_activite_path(associations(:one), assigns(:activite))
  end
  
  def test_should_destroy_activite
    old_count = Activite.count
    delete :destroy, :id => 1, :association_id => associations(:one)
    assert_equal old_count-1, Activite.count
    
    assert_redirected_to association_activites_path(associations(:one))
  end
end
