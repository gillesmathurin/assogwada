# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'

class ConseiladminTest < Test::Unit::TestCase
  fixtures :conseiladmins

  # Replace this with your real tests.
  def test_truth
    assert true
  end
  
  def test_invalid_with_empty_attributes
    ca = Conseiladmin.new
    assert !ca.valid?
    assert ca.errors.invalid?(:annee_dbt)
    assert ca.errors.invalid?(:annee_fin)
    
    ca.annee_dbt = Time.now.year
    ca.annee_fin = Time.now.year
    assert ca.valid?
  end
end
