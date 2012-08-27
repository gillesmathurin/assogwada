# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'

class AdhesionTest < Test::Unit::TestCase
  fixtures :adhesions

  # Replace this with your real tests.
  def test_truth
    assert true
  end
  
  def test_invalid_with_empty_or_wrong_attribute
    adhesion = Adhesion.new()
    assert !adhesion.valid?, adhesion.errors.full_messages
    
    adhesion.association_id ="string"
    adhesion.membre_id = "string"
    assert !adhesion.valid?, adhesion.errors.full_messages
    
    adhesion.association_id = 1
    adhesion.membre_id = 1
    assert adhesion.valid?, adhesion.errors.full_messages
  end
  
  def test_invalid_with_nonnumerical_attribute
    adhesion = Adhesion.new()
    adhesion.association_id = "string"
    adhesion.membre_id = "string"
    assert !adhesion.valid?, adhesion.errors.full_messages
    assert_equal("doit être un entier", adhesion.errors.on(:association_id))
    assert_equal("doit être un entier", adhesion.errors.on(:membre_id))    
  end
  
end
