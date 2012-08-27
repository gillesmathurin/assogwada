# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'
require 'salaries_controller'

# Re-raise errors caught by the controller.
class SalariesController; def rescue_action(e) raise e end; end

class SalariesControllerTest < Test::Unit::TestCase
  fixtures :salaries, :associations

  def setup
    @controller = SalariesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index, :association_id => associations(:one)
    assert_response :success
    assert assigns(:salaries)
  end

  def test_should_get_new
    get :new, :association_id => associations(:one)
    assert_response :success
  end
  
  def test_should_create_salarie
    old_count = Salarie.count
    post :create, :salarie => {:poste => "technicien reseau",
                               :sexe => "M", :contrat_classique => false,
                               :contrat_aide => true}, :association_id => associations(:one)
    assert_equal old_count+1, Salarie.count
    
    assert_redirected_to association_salarie_path(associations(:one), assigns(:salarie))
  end

  def test_should_show_salarie
    get :show, :id => 1, :association_id => associations(:one)
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1, :association_id => associations(:one)
    assert_response :success
  end
  
  def test_should_update_salarie
    put :update, :id => 1, :association_id => associations(:one), :salarie => { }
    assert_redirected_to association_salarie_path(associations(:one), assigns(:salarie))
  end
  
  def test_should_destroy_salarie
    old_count = Salarie.count
    delete :destroy, :id => 1, :association_id => associations(:one)
    assert_equal old_count-1, Salarie.count
    
    assert_redirected_to association_salaries_path(associations(:one))
  end
end
