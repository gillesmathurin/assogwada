# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'
require 'associations_champ_interventions_controller'

# Re-raise errors caught by the controller.
class AssociationsChampInterventionsController; def rescue_action(e) raise e end; end

class AssociationsChampInterventionsControllerTest < Test::Unit::TestCase
  fixtures :associations_champ_interventions

  def setup
    @controller = AssociationsChampInterventionsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:associations_champ_interventions)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_associations_champ_intervention
    old_count = AssociationsChampIntervention.count
    post :create, :associations_champ_intervention => { }
    assert_equal old_count+1, AssociationsChampIntervention.count
    
    assert_redirected_to associations_champ_intervention_path(assigns(:associations_champ_intervention))
  end

  def test_should_show_associations_champ_intervention
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_associations_champ_intervention
    put :update, :id => 1, :associations_champ_intervention => { }
    assert_redirected_to associations_champ_intervention_path(assigns(:associations_champ_intervention))
  end
  
  def test_should_destroy_associations_champ_intervention
    old_count = AssociationsChampIntervention.count
    delete :destroy, :id => 1
    assert_equal old_count-1, AssociationsChampIntervention.count
    
    assert_redirected_to associations_champ_interventions_path
  end
end
