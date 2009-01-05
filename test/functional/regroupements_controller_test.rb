require File.dirname(__FILE__) + '/../test_helper'
require 'regroupements_controller'

# Re-raise errors caught by the controller.
class RegroupementsController; def rescue_action(e) raise e end; end

class RegroupementsControllerTest < Test::Unit::TestCase
  fixtures :regroupements

  def setup
    @controller = RegroupementsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:regroupements)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_regroupement
    old_count = Regroupement.count
    post :create, :regroupement => { }
    assert_equal old_count+1, Regroupement.count
    
    assert_redirected_to regroupement_path(assigns(:regroupement))
  end

  def test_should_show_regroupement
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_regroupement
    put :update, :id => 1, :regroupement => { }
    assert_redirected_to regroupement_path(assigns(:regroupement))
  end
  
  def test_should_destroy_regroupement
    old_count = Regroupement.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Regroupement.count
    
    assert_redirected_to regroupements_path
  end
end
