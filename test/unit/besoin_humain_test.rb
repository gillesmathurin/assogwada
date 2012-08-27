# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'

class BesoinHumainTest < Test::Unit::TestCase
  fixtures :besoin_humains

  # Replace this with your real tests.
  def test_truth
    assert true
  end
  
  def test_invalid_with_empty_attributes
    besoin = BesoinHumain.new()
    assert !besoin.valid?
    
    besoin.categorie = "string"
    besoin.quantite = 2
    assert besoin.valid?, besoin.errors.full_messages
  end
  
  def test_invalid_with_non_numeric_quantite
    besoin = BesoinHumain.new(:categorie => "string", :quantite => "string")
    assert !besoin.valid?
    assert_equal("la quantité doit être un chiffre entier", besoin.errors.on(:quantite))
  end
end
