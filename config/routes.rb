Rails.application.routes.draw do
  mount Blacklight::Engine => '/'

  root to: "catalog#index", collection: 'vbl'
  concern :searchable, Blacklight::Routes::Searchable.new

  resource :catalog, only: [:index], as: 'catalog', path: '/catalog', controller: 'catalog' do
    concerns :searchable
  end

  concern :exportable, Blacklight::Routes::Exportable.new

  resources :solr_documents, only: [:show], path: '/catalog', controller: 'catalog' do
    concerns :exportable
  end

  resources :bookmarks do
    concerns :exportable

    collection do
      delete 'clear'
    end
  end

  # Create named routes for each collection specified in tabs.yml
  YAML.load_file( File.join(Rails.root, "config", "repositories.yml") )["Catalog"]["repositories"].each do |coll|
     get "#{coll[0]}" => "catalog#index", :collection => "#{coll[0]}"
  end

  scope "admin" do
    resources :records do
      patch 'upload', :on => :collection
    end
    resources :users
    delete "clear_patron_data", :to => "users#clear_patron_data"
  end

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get 'logout', to: 'devise/sessions#destroy', as: :logout
    get 'login', to: redirect { |params, request| "#{Rails.application.config.relative_url_root}/users/auth/nyulibraries?#{request.query_string}" }, as: :login
  end
end
