Umbra::Application.routes.draw do

  Blacklight.add_routes(self)

  root :to => "catalog#index", :collection => "vbl"

  # Create named routes for each collection specified in tabs.yml
  YAML.load_file( File.join(Rails.root, "config", "repositories.yml") )["Catalog"]["repositories"].each do |coll|
     get "#{coll[0]}" => "catalog#index", :collection => "#{coll[0]}"
  end
      
  scope "admin" do
    resources :records do
      post 'upload', :on => :collection
    end
    resources :users
    delete "clear_patron_data", :to => "users#clear_patron_data"
  end
  
  match 'login', :to => 'user_sessions#new', :as => :login
  match 'logout', :to => 'user_sessions#destroy', :as => :logout
  match 'validate', :to => 'user_sessions#validate', :as => :validate
  resources :user_sessions
  
end
