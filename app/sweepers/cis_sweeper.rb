class CisSweeper < ActionController::Caching::Sweeper
  observe ChampIntervention
  
  def after_save(champ_intervention)
    expire_cache(champ_intervention)
  end
  
  def after_destroy(champ_intervention)
    expire_cache(champ_intervention)
  end
  
  def expire_cache(champ_intervention)
    expire_page :controller => 'recherches', :action => 'new'
    expire_page :controller => 'associations', :action => 'inscription'
  end
  
end