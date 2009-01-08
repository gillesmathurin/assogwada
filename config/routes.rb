ActionController::Routing::Routes.draw do |map|
  map.resources :nl_contents

  map.resources :newsletters, :has_many => :nl_contents, :member => { :deliver => :get },
   :collection => { :desabonnement => :get, :delete_abonne => :put }

  map.resources :quests

  map.resources :conventions

  map.resources :associations_champ_interventions

  map.resources :conv_pluris

  map.resources :dispositifs do |dispositifs|
    dispositifs.resources :regroupements, :name_prefix => "dispositif_"
  end

  map.resources :plannings
  
  map.resources :associations,
   :collection => {:add_ci => :get, :remove_ci => :post,
      :inscription => :get, :download_quest => :get, :test_exception => :get,
      :envoi => :post, :envoi_inscription => :post, :accueil => :get, :verify => :get,
      :export_xls_csv => :get, :incomplete => :get, :form_abonnement => :get, :envoi_formabonnement => :post, :newsletter => :post },
    :member => { :accept => :put, :reject => :put, :unsuspend => :put, :suspend => :put } do |associations|
    associations.resources :salaries, :name_prefix => "association_",
     :singular => 'salarie'
    associations.resources :locals, :name_prefix => "association_"
    associations.resources :besoin_humains, :name_prefix => "association_"
    associations.resources :besoin_materiels, :name_prefix => "association_"
    associations.resources :activites, :name_prefix => "association_"
    associations.resources :regroupements, :name_prefix => "association_"
    associations.resources :dispositifs, :name_prefix => "association_"
    associations.resources :agrements, :name_prefix => "association_"
    associations.resources :orgahabs, :name_prefix => "association_"
    associations.resources :adhesions, :name_prefix => "association_"
    associations.resources :assoc_manifs, :name_prefix => "association_"
    associations.resources :manifestations, :name_prefix => "association_"
    associations.resources :assoc_champintervs, :name_prefix => "association_"
    associations.resources :champ_interventions, :name_prefix => "association_"
    associations.resources :membres, :name_prefix => "association_"
    associations.resources :conseiladmins, :name_prefix => "association_"
    associations.resources :conv_pluris, :name_prefix => "association_"
  end
  
  map.resources :conseiladmins do |conseiladmins|
    conseiladmins.resources :presidents, :name_prefix => "conseiladmin_"
    conseiladmins.resources :premier_vicepresidents, :name_prefix => "conseiladmin_"
    conseiladmins.resources :second_vicepresidents, :name_prefix => "conseiladmin_"
    conseiladmins.resources :secretaires, :name_prefix => "conseiladmin_"
    conseiladmins.resources :secretaire_adjoints, :name_prefix => "conseiladmin_"
    conseiladmins.resources :tresoriers, :name_prefix => "conseiladmin_"
    conseiladmins.resources :tresorier_adjoints, :name_prefix => "conseiladmin_"
    conseiladmins.resources :membres, :name_prefix => "conseiladmin_"
  end
  
  map.resources :regroupements

  map.resources :agrements

  map.resources :orgahabs do |orgahabs|
    orgahabs.resources :agrements, :name_prefix => "orgabhab_"
    orgahabs.resources :conv_pluris, :name_prefix => "orgabhab_"
  end

  map.resources :adhesions

  map.resources :assoc_manifs

  map.resources :membres

  map.resources :manifestations do |manif|
    manif.resources :associations, :name_prefix => "manifestation_"
  end

  map.resources :champ_interventions

  map.resources :salaries, :singular => 'salarie'

  map.resources :activites do |activites|
    activites.resources :plannings, :name_prefix => "activite_"
  end

  map.resources :besoin_materiels
  
  map.resources :besoin_humains
  
  map.resources :locals
  
  map.resources :users
  
  map.resource :session, :controller => 'sessions'
  
  map.resources :recherches, :controller => 'recherches',
   :collection => {:liste => :get, :commune => :post, :export_result => :get, :export_excel => :get}
   
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login  '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.demande_abonnement '/demande_abonnement', :controller => 'associations', :action => 'form_abonnement'
  
  # map.commune 'commune/:id', :controller => 'recherches', :action => 'commune'
  
  # The priority is based upon order of creation: first created -> highest priority.
  
  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # You can have the root of your site routed by hooking up '' 
  # -- just remember to delete public/index.html.
  map.connect '', :controller => "associations", :action => "accueil"

  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  map.connect ':controller/service.wsdl', :action => 'wsdl'

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
