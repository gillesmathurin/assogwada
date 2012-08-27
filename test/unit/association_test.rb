# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'

class AssociationTest < Test::Unit::TestCase
  fixtures :associations

  # Replace this with your real tests.
  def test_truth
    assert true
  end
  
  def test_invalid_with_empty_attributes
    association = Association.new
    assert !association.valid?
    assert association.errors.invalid?(:nom)
    assert association.errors.invalid?(:adresse_siegesocial)
    assert association.errors.invalid?(:cp)
    assert association.errors.invalid?(:ville)
    assert association.errors.invalid?(:telephone)
    assert association.errors.invalid?(:fax)
    assert association.errors.invalid?(:objet_social)
    assert association.errors.invalid?(:cotisation_annuelle)
    assert association.errors.invalid?(:droit_entree)                   
  end
  
  def test_telephone_and_fax_format
    association = Association.new(:nom => "association",
      :adresse_siegesocial => "ruelle jeanne d'arc",
      :cp => 97180, :ville => "Sainte-Anne",
      :objet_social => "objet social", :cotisation_annuelle => 1,
      :droit_entree => 1, :email => "email@mail.com")
    association.telephone = "string"
    association.fax = "string"
    assert !association.valid?
    assert_equal("n° de telephone incorrect", association.errors.on(:telephone))
    assert_equal("n° de fax incorrect", association.errors.on(:fax))
    
    association.telephone = "0590883013"
    association.fax = "0590853357"
    assert association.valid?, association.errors.full_messages
  end
  
  def test_email_format
    ok = %w{ email@mac.com email@wanadoo.fr gillesmath@orange.fr }
    bad = %w{ email_at_mac.com outromako noneofyour@business }
    
    ok.each do |email|
      association = Association.new(:nom => "association",
        :adresse_siegesocial => "ruelle jeanne d'arc",
        :cp => 97180, :ville => "Sainte-Anne",
        :objet_social => "objet social", :cotisation_annuelle => 1,
        :droit_entree => 1,
        :email => email,
        :telephone => "0590883013",
        :fax => "0590883013")
      assert association.valid?, association.errors.full_messages
    end
    
    bad.each do |email|
      association = Association.new(:nom => "association",
        :adresse_siegesocial => "ruelle jeanne d'arc",
        :cp => 97180, :ville => "Sainte-Anne",
        :objet_social => "objet social", :cotisation_annuelle => 1,
        :droit_entree => 1,
        :email => email,
        :telephone => "0590883013",
        :fax => "0590883013")
      assert !association.valid?, "saving #{email}" 
    end
  end
  
end
