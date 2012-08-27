# -*- encoding : utf-8 -*-
class AssociationSweeper < ActionController::Caching::Sweeper
  observe Association
  
  def after_save(association)
    expire_cache(association)
  end
  
  def after_destroy(association)
    expire_cache(association)
  end
  
  def expire_cache(association)
    expire_page :controller => 'associations', :action => 'accueil'
  end
  
end
