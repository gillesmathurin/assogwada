require File.dirname(__FILE__) + '/../test_helper'

class AgrementTest < Test::Unit::TestCase
  fixtures :agrements

  # Replace this with your real tests.
  def test_truth
    assert true
  end
  
  def test_invalid_with_empty_attributes
    agrement = Agrement.new()
    assert !agrement.valid?
    agrement.nom = "string"
    assert agrement.valid?
  end
end
