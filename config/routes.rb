Rails.application.routes.draw do
  blacklight_for :catalog

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

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    # get 'users/:provider/:id', to: 'users#show', as: 'user', constraints: { provider: "nyulibraries" }
    get 'logout', to: 'devise/sessions#destroy', as: :logout
    get 'login/', to: redirect('/umbra/users/auth/nyulibraries'), as: :login
  end
end
