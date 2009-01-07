# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  # protect_from_forgery # :secret => '558085ee089970a5b52075f2a6a02a6c'
  
  include AuthenticatedSystem
  include ExceptionNotifiable
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_assogwada_session_id'

  def call_rake(task, options = {})
    options[:rails_env] ||= RAILS_ENV
    args = options.map { |n,v| "#{n.to_s.upcase}='#{v}'" }
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
