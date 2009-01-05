require File.dirname(__FILE__) + '/../test_helper'
require 'assoc_manifs_controller'

# Re-raise errors caught by the controller.
class AssocManifsController; def rescue_action(e) raise e end; end

class AssocManifsControllerTest < Test::Unit::TestCase
  fixtures :assoc_manifs, :associations, :manifestations

  def setup
    @controller = AssocManifsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index, :association_id => associations(:one),
     :manifestation_id => manifestations(:one)
    assert_response :success
    assert assigns(:assoc_manifs)
  end

  def test_should_get_new
    get :new, :association_id => associations(:one),
     :manifestation_id => manifestations(:one)
    assert_response :success
  end
  
  def test_should_create_assoc_manif
    old_count = AssocManif.count
    post :create,:association_id => associations(:one),
    :manifestation_id => manifestations(:one), :assoc_manif => { }
    assert_equal old_count+1, AssocManif.count
    
    assert_redirected_to assoc_manif_path(assigns(:assoc_manif))
  end

  def test_should_show_assoc_manif
    get :show, :id => 1, :association_id => associations(:one),
     :manifestation_id => manifestations(:one)
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1, :association_id => associations(:one), 
     :manifestation_id => manifestations(:one)
    assert_response :success
  end
  
  def test_should_update_assoc_manif
    put :update, :id => 1, :association_id => associations(:one),
    :manifestation_id => manifestations(:one), 
    :assoc_manif => { }
    assert_redirected_to assoc_manif_path(assigns(:assoc_manif))
  end
  
  def test_should_destroy_assoc_manif
    old_count = AssocManif.count
    delete :destroy, :id => 1, :association_id => associations(:one),
    :manifestation_id => manifestations(:one)
    assert_equal old_count-1, AssocManif.count
    
    assert_redirected_to assoc_manifs_path
  end
end
