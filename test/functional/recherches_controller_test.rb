# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'
require 'recherches_controller'

# Re-raise errors caught by the controller.
class RecherchesController; def rescue_action(e) raise e end; end

class RecherchesControllerTest < Test::Unit::TestCase
  def setup
    @controller = RecherchesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
