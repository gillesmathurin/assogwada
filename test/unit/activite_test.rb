require File.dirname(__FILE__) + '/../test_helper'

class ActiviteTest < Test::Unit::TestCase
  fixtures :activites

  # Replace this with your real tests.
  def test_truth
    assert true
  end
  
  def test_invalid_with_empty_attributes
    activite = Activite.new
    
    assert !activite.valid?
    assert activite.errors.invalid?(:nom)
    assert activite.errors.invalid?(:spectateur)
  end
  
  def test_numericality_validation_of_tarif_mensuel
    activite = Activite.new(:nom => "tir à l'arc", :spectateur => "enfants", :licence => 50)
      
    activite.tarif_mensuel = "string"
    assert !activite.valid?, activite.errors.full_messages
    
    activite.tarif_mensuel = 25
    assert activite.valid?, activite.errors.full_messages
  end
  
  def test_numericality_validation_of_licence
    activite = Activite.new(:nom => "string", :spectateur => "TP", :tarif_mensuel => 25)
    
    activite.licence = "string"
    assert !activite.valid?, activite.errors.full_messages
    
    activite.licence = 50
    assert activite.valid?, activite.errors.full_messages
  end
end
