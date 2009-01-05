require File.dirname(__FILE__) + '/../test_helper'
require 'adhesions_controller'

# Re-raise errors caught by the controller.
class AdhesionsController; def rescue_action(e) raise e end; end

class AdhesionsControllerTest < Test::Unit::TestCase
  fixtures :adhesions

  def setup
    @controller = AdhesionsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:adhesions)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_adhesion
    old_count = Adhesion.count
    post :create, :adhesion => { }
    assert_equal old_count+1, Adhesion.count
    
    assert_redirected_to adhesion_path(assigns(:adhesion))
  end

  def test_should_show_adhesion
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_adhesion
    put :update, :id => 1, :adhesion => { }
    assert_redirected_to adhesion_path(assigns(:adhesion))
  end
  
  def test_should_destroy_adhesion
    old_count = Adhesion.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Adhesion.count
    
    assert_redirected_to adhesions_path
  end
end
