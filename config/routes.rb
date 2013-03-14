Umbra::Application.routes.draw do

  root :to => "catalog#index"

  # Create named routes for each collection specified in tabs.yml
  YAML.load_file( File.join(Rails.root, "config", "tabs.yml") )["Catalog"]["views"]["tabs"].each do |coll|
     match "#{coll[0]}" => "catalog#index", :collection => "#{coll[0]}"
  end
  
  Blacklight.add_routes(self)
    
  scope "admin" do
    resources :records do
      post 'upload', :on => :collection
    end
    resources :users
  end
  
  match 'login', :to => 'user_sessions#new', :as => :login
  match 'logout', :to => 'user_sessions#destroy', :as => :logout
  match 'validate', :to => 'user_sessions#validate', :as => :validate
  resources :user_sessions
  
end
