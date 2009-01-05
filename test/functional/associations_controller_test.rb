require File.dirname(__FILE__) + '/../test_helper'
require 'associations_controller'

# Re-raise errors caught by the controller.
class AssociationsController; def rescue_action(e) raise e end; end

class AssociationsControllerTest < Test::Unit::TestCase
  fixtures :associations, :champ_interventions

  def setup
    @controller = AssociationsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:associations)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_association
    old_count = Association.count
    post :create, :ci => {:champ_interventions => champ_interventions(:one)},
    :association => {:nom => "association",
    :adresse_siegesocial => "ruelle jeanne d'arc",
    :cp => 97180, :ville => "Sainte-Anne",
    :objet_social => "objet social", :cotisation_annuelle => 1,
    :droit_entree => 1,
    :email => "email@mail.com",
    :telephone => "0590883013",
    :fax => "0590883013" }
    assert_equal old_count+1, Association.count
    
    assert_redirected_to association_path(assigns(:association))
  end

  def test_should_show_association
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_association
    put :update, :id => 1,
      :ci => {:champ_interventions => champ_interventions(:one)},
      :association => {:nom => "association",
      :adresse_siegesocial => "ruelle jeanne d'arc",
      :cp => 97180, :ville => "Sainte-Anne",
      :objet_social => "objet social", :cotisation_annuelle => 1,
      :droit_entree => 1,
      :email => "email@mail.com",
      :telephone => "0590883013",
      :fax => "0590883013" }
    assert_redirected_to association_path(assigns(:association))
  end
  
  def test_should_destroy_association
    old_count = Association.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Association.count
    
    assert_redirected_to associations_path
  end
end
