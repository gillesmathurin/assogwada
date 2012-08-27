# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'
require 'besoin_humains_controller'

# Re-raise errors caught by the controller.
class BesoinHumainsController; def rescue_action(e) raise e end; end

class BesoinHumainsControllerTest < Test::Unit::TestCase
  fixtures :besoin_humains, :associations

  def setup
    @controller = BesoinHumainsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index, :association_id => associations(:two)
    assert_response :success
    assert assigns(:besoin_humains)
  end

  def test_should_get_new
    get :new, :association_id => associations(:two)
    assert_response :success
  end
  
  def test_should_create_besoin_humain
    old_count = BesoinHumain.count
    post :create, :besoin_humain => { }, :association_id => associations(:two)
    assert_equal old_count+1, BesoinHumain.count
    
    assert_redirected_to association_besoin_humain_path(associations(:two), 
    assigns(:besoin_humain))
  end

  def test_should_show_besoin_humain
    get :show, :id => 1, :association_id => associations(:two)
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1, :association_id => associations(:two)
    assert_response :success
  end
  
  def test_should_update_besoin_humain
    put :update, :id => 1, :besoin_humain => { }, :association_id => associations(:two)
    assert_redirected_to association_besoin_humain_path(associations(:two),
      assigns(:besoin_humain))
  end
  
  def test_should_destroy_besoin_humain
    old_count = BesoinHumain.count
    delete :destroy, :id => 1, :association_id => associations(:two)
    assert_equal old_count-1, BesoinHumain.count
    
    assert_redirected_to association_besoin_humains_path(associations(:two))
  end
end
