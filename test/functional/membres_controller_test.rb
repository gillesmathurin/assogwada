# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'
require 'membres_controller'

# Re-raise errors caught by the controller.
class MembresController; def rescue_action(e) raise e end; end

class MembresControllerTest < Test::Unit::TestCase
  fixtures :membres

  def setup
    @controller = MembresController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:membres)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_membre
    old_count = Membre.count
    post :create, :membre => { }
    assert_equal old_count+1, Membre.count
    
    assert_redirected_to membre_path(assigns(:membre))
  end

  def test_should_show_membre
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_membre
    put :update, :id => 1, :membre => {:email => "mail@email.com" }
    assert_redirected_to membre_path(assigns(:membre))
  end
  
  def test_should_destroy_membre
    old_count = Membre.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Membre.count
    
    assert_redirected_to membres_path
  end
end
