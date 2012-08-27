# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'
require 'champ_interventions_controller'

# Re-raise errors caught by the controller.
class ChampInterventionsController; def rescue_action(e) raise e end; end

class ChampInterventionsControllerTest < Test::Unit::TestCase
  fixtures :champ_interventions

  def setup
    @controller = ChampInterventionsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:champ_interventions)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_champ_intervention
    old_count = ChampIntervention.count
    post :create, :champ_intervention => { }
    assert_equal old_count+1, ChampIntervention.count
    
    assert_redirected_to champ_intervention_path(assigns(:champ_intervention))
  end

  def test_should_show_champ_intervention
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_champ_intervention
    put :update, :id => 1, :champ_intervention => { }
    assert_redirected_to champ_intervention_path(assigns(:champ_intervention))
  end
  
  def test_should_destroy_champ_intervention
    old_count = ChampIntervention.count
    delete :destroy, :id => 1
    assert_equal old_count-1, ChampIntervention.count
    
    assert_redirected_to champ_interventions_path
  end
end
