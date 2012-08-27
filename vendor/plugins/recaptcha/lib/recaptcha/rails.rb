# -*- encoding : utf-8 -*-
require 'recaptcha'

ActionView::Base.send(:include, Recaptcha::ClientHelper)
ActionController::Base.send(:include, Recaptcha::Verify)
