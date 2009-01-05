require File.dirname(__FILE__) + '/../test_helper'
require 'conventions_controller'

# Re-raise errors caught by the controller.
class ConventionsController; def rescue_action(e) raise e end; end

class ConventionsControllerTest < Test::Unit::TestCase
  fixtures :conventions

  def setup
    @controller = ConventionsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:conventions)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_convention
    old_count = Convention.count
    post :create, :convention => { }
    assert_equal old_count+1, Convention.count
    
    assert_redirected_to convention_path(assigns(:convention))
  end

  def test_should_show_convention
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_convention
    put :update, :id => 1, :convention => { }
    assert_redirected_to convention_path(assigns(:convention))
  end
  
  def test_should_destroy_convention
    old_count = Convention.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Convention.count
    
    assert_redirected_to conventions_path
  end
end
