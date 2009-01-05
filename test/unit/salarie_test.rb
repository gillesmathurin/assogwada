require File.dirname(__FILE__) + '/../test_helper'

class SalarieTest < Test::Unit::TestCase
  fixtures :salaries

  # Replace this with your real tests.
  def test_truth
    assert true
  end
  
  def test_invalid_with_empty_attributes
    salarie = Salarie.new()
    assert !salarie.valid?
    assert salarie.errors.invalid?(:sexe)
    assert salarie.errors.invalid?(:poste)
    
    salarie.sexe = "M"
    salarie.poste = "Developpeur Web"
    assert salarie.valid?
  end
end
