require File.dirname(__FILE__) + '/../test_helper'

class OrgahabTest < Test::Unit::TestCase
  fixtures :orgahabs

  # Replace this with your real tests.
  def test_truth
    assert true
  end
  
  def test_invalid_with_empty_attributes
    org = Orgahab.new()
    assert !org.valid?
    assert org.errors.invalid?(:nom)
    assert_equal("can't be blank", org.errors.on(:nom))
    
    org.nom = "Organisme"
    assert org.valid?
  end
end
