# -*- encoding : utf-8 -*-
# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery 
  
  def call_rake(task, options = {})
    options[:rails_env] ||= RAILS_ENV
    args = options.map do |n,v|
      if n.to_s.upcase == "RESULTATS"
        "#{n.to_s.upcase}='[#{v.join(", ")}]'"
      else
       "#{n.to_s.upcase}='#{v}'"
      end
    end
    
    # system "/usr/local/bin/rake #{task} #{args.join(' ')} --trace 2>&1 >> #{RAILS_ROOT}/log/rake.log &"
    system "/usr/bin/rake #{task} #{args.join(' ')} --trace 2>&1 >> #{RAILS_ROOT}/log/rake.log &"
  end
  
  protected

  def find_association
    @association = Association.find(params[:association_id]) if params[:association_id]
  end
  
  def last_recorded
    @last_recorded = Association.last_recorded
  end
  
  # Gère les exceptions de l'application en Production
  def rescue_action_in_public(exception)
    case exception  
    when ActiveRecord::RecordNotFound
      render(:file	=> "#{RAILS_ROOT}/public/404.html",	:status	=> "404 Not Found")
    when ActionController::RoutingError
      render(:file	=> "#{RAILS_ROOT}/public/404.html",	:status	=> "404 Not Found")
    when NoMethodError
      render :file => "#{RAILS_ROOT}/public/500.html"
    else
      render :file => "#{RAILS_ROOT}/public/500.html"
    end
  end
end
