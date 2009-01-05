require File.dirname(__FILE__) + '/../test_helper'

class BesoinMaterielTest < Test::Unit::TestCase
  fixtures :besoin_materiels

  # Replace this with your real tests.
  def test_truth
    assert true
  end
  
  def test_invalid_with_empty_attributes
    besoin = BesoinMateriel.new()
    assert !besoin.valid?
    assert besoin.errors.invalid?(:categorie)
    assert besoin.errors.invalid?(:desc)
    assert besoin.errors.invalid?(:quantite)
  end
  
  def test_invalid_with_nonnumeric_quantite
    besoin = BesoinMateriel.new(:categorie => "string",
      :desc => "description")
    besoin.quantite = "string"
    assert !besoin.valid?, besoin.errors.full_messages
    
    besoin.quantite = 1,25
    assert besoin.valid?, besoin.errors.full_messages
    
    besoin.quantite = 3
    assert besoin.valid?, besoin.errors.full_messages
  end
end
