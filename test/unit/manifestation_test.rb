require File.dirname(__FILE__) + '/../test_helper'

class ManifestationTest < Test::Unit::TestCase
  fixtures :manifestations

  # Replace this with your real tests.
  def test_truth
    assert true
  end
  
  def test_invalid_with_empty_attributes
    manif = Manifestation.new()
    assert !manif.valid?
    assert manif.errors.invalid?(:nom)
    assert manif.errors.invalid?(:spectateur)
    assert manif.errors.invalid?(:prix)
        
    manif = Manifestation.new(
      :nom => "foubapantotusoss",
      :spectateur => "enfant",
      :prix => 20)
    assert manif.valid?, manif.errors.full_messages
  end
  
  def test_invalid_with_bad_prix
    manif = Manifestation.new(
      :nom => "foubapantotusoss",
      :spectateur => "enfant",
      :prix => "string")
    assert !manif.valid?
    assert manif.errors.invalid?(:prix)
    assert_equal("is not a number", manif.errors.on(:prix))
    
    manif.prix = 20
    assert manif.valid?
  end
end
