# -*- encoding : utf-8 -*-
Assogwada::Application.routes.draw do
  devise_for :users

  resources :newsletters
  
  resources :mailings
  
  resources :quests

  resources :conventions

  resources :associations_champ_interventions

  resources :conv_pluris

  resources :dispositifs do
    resources :regroupements
  end

  resources :plannings
  
  resources :associations do
    collection do
      get 'add_ci'
      get 'inscription'
      get 'download_quest'
      get 'test_exception'
      get 'accueil'
      get 'verify'
      get 'export_xls_csv'
      get 'incomplete'
      get 'form_abonnement'
      post 'remove_ci'
      post 'envoi'
      post 'envoi_inscription'
      post 'envoi_formabonnement'
      post 'newsletter'
    end
    member do
      put 'accept'
      put 'reject'
      put 'unsuspend'
      put 'suspend'
    end
    resources :salaries, :singular => 'salarie'
    resources :locals
    resources :besoin_humains
    resources :besoin_materiels
    resources :activites
    resources :regroupements
    resources :dispositifs
    resources :agrements
    resources :orgahabs
    resources :adhesions
    resources :assoc_manifs
    resources :manifestations
    resources :assoc_champintervs
    resources :champ_interventions
    resources :membres
    resources :conseiladmins
    resources :conv_pluris
  end
  
  resources :conseiladmins do
    resources :presidents
    resources :premier_vicepresidents
    resources :second_vicepresidents
    resources :secretaires
    resources :secretaire_adjoints
    resources :tresoriers
    resources :tresorier_adjoints
    resources :membres
  end
  
  resources :regroupements

  resources :agrements

  resources :orgahabs do
    resources :agrements
    resources :conv_pluris
  end

  resources :adhesions

  resources :assoc_manifs

  resources :membres

  resources :manifestations do
    resources :associations
  end

  resources :champ_interventions

  resources :salaries, :singular => 'salarie'

  resources :activites do
    resources :plannings
  end

  resources :besoin_materiels
  
  resources :besoin_humains
  
  resources :locals
  
  resources :users
    
  # resources :recherches, :controller => 'recherches',
  #  :collection => {:liste => :get, :commune => :post, :export_result => :get, :export_excel => :get}

  resource :recherches do
    collection do
      get 'liste'
      post 'commune'
      get 'export_result'
      get 'export_excel'
    end
  end

  match '/recherch/:id' => 'recherches#show', :as => 'recherch'
   
  # match '/signup', :controller => 'users', :action => 'new'
  # match  '/login', :controller => 'sessions', :action => 'new'
  match '/logout', :controller => 'sessions', :action => 'destroy'
  match '/demande_abonnement', :controller => 'associations', :action => 'form_abonnement'
  
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
  # map.connect '', :controller => "associations", :action => "accueil"
  root :to => 'associations#accueil'

  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  match ':controller/service.wsdl', :action => 'wsdl'

  # Install the default route as the lowest priority.
  match ':controller(/:action(/:id(.:format)))'
end