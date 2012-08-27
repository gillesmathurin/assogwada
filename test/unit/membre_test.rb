# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'

class MembreTest < Test::Unit::TestCase
  fixtures :membres

  # Replace this with your real tests.
  def test_truth
    assert true
  end
  
  def test_invalid_with_bad_email
    ok = %w{ email@mac.com email@wanadoo.fr gillesmath@orange.fr }
    bad = %w{ email_at_mac.com outromako noneofyour@business }
    
    ok.each do |email|
      membre = Membre.new(:nom => "membre",
        :prenom => "prenom",
        :email => email,
        :telephone => "0590883013",
        :fax => "0590883013")
      assert membre.valid?, membre.errors.full_messages
    end
    
    bad.each do |email|
      membre = Membre.new(:nom => "membre",
        :prenom => "prenom",
        :email => email,
        :telephone => "0590883013",
        :fax => "0590883013")
      assert !membre.valid?, "saving #{email}" 
    end
  end
end
