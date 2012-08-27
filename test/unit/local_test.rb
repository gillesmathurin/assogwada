# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'

class LocalTest < Test::Unit::TestCase
  fixtures :locals

  # Replace this with your real tests.
  def test_truth
    assert true
  end
  
  def test_invalid_with_empty_attributes
    local = Local.new
    assert !local.valid?
    assert local.errors.invalid?(:adresse)
    assert local.errors.invalid?(:cp)
    assert local.errors.invalid?(:ville)
    assert local.errors.invalid?(:jour_recep_debut)
    assert local.errors.invalid?(:jour_recep_fin)
    assert local.errors.invalid?(:h_recep_debut)
    assert local.errors.invalid?(:h_recep_fin)
    
    local = Local.new(:adresse => "ruelle jeanne d'arc",
      :cp => 97180, :ville => "string", 
      :jour_recep_debut => Time.now.day,
      :jour_recep_fin => (Time.now + 10.days).day,
      :h_recep_debut => Time.parse("9:00"),
      :h_recep_fin => Time.parse("11:00"))
    assert local.valid?, local.errors.full_messages
  end
  
  def test_invalid_with_nonnumeric_cp
    local = Local.new(:adresse => "ruelle jeanne d'arc",
      :cp => "string", :ville => "string", 
      :jour_recep_debut => Time.now.day,
      :jour_recep_fin => (Time.now + 10.days).day,
      :h_recep_debut => Time.parse("9:00"),
      :h_recep_fin => Time.parse("11:00"))
    assert !local.valid?
    
    local.cp = 97180
    assert local.valid?, local.errors.full_messages
  end
end
