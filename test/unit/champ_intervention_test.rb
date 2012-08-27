# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'

class ChampInterventionTest < Test::Unit::TestCase
  fixtures :champ_interventions

  # Replace this with your real tests.
  def test_truth
    assert true
  end
  
  def test_invalid_with_empty_attributes
    ci = ChampIntervention.new()
    assert !ci.valid?
    assert ci.errors.invalid?(:nom)
    
    ci.nom = "string"
    assert ci.valid?
  end
end
