require File.dirname(__FILE__) + '/../test_helper'
require 'plannings_controller'

# Re-raise errors caught by the controller.
class PlanningsController; def rescue_action(e) raise e end; end

class PlanningsControllerTest < Test::Unit::TestCase
  fixtures :plannings

  def setup
    @controller = PlanningsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:plannings)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_planning
    old_count = Planning.count
    post :create, :planning => { }
    assert_equal old_count+1, Planning.count
    
    assert_redirected_to planning_path(assigns(:planning))
  end

  def test_should_show_planning
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_planning
    put :update, :id => 1, :planning => { }
    assert_redirected_to planning_path(assigns(:planning))
  end
  
  def test_should_destroy_planning
    old_count = Planning.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Planning.count
    
    assert_redirected_to plannings_path
  end
end
