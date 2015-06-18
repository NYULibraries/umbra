class ApplicationController < ActionController::Base
  # Adds a few additional behaviors into the application controller
  prepend_before_filter :passive_login
  include Blacklight::Controller

  include Umbra::Collections
  helper_method :collections_user_can_admin, :current_collection, :current_user_has_access_to_collection?, :collection_codes, :collection_name

  # Please be sure to impelement current_user and user_session. Blacklight depends on
  # these methods in order to perform user specific actions.

  protect_from_forgery
  layout Proc.new{ |controller| (controller.request.xhr?) ? false : "application" }

  # If user is an admin pass back true, otherwise redirect to root
  def authenticate_admin
    unless current_user && current_user.admin?
      redirect_to(root_path) and return
    else
      return true
    end
  end

  # Check for passive login if you haven't already 
  def passive_login
    if !cookies[:_check_passive_login]
      cookies[:_check_passive_login] = true
      redirect_to passive_login_url
    end
  end

  # After signing out from the local application,
  # redirect to the logout path for the Login app
  def after_sign_out_path_for(resource_or_scope)
    if ENV['SSO_LOGOUT_URL'].present?
      ENV['SSO_LOGOUT_URL']
    else
      super(resource_or_scope)
    end
  end

  # Alias new_session_path as login_path for default devise config
  def new_session_path(scope)
    login_path
  end

  # Imitate logged in admin in dev
  def current_user_dev
    @current_user ||= User.new(email: "user@nyu.edu", firstname: "Julius", username: "jcVI", admin: true, admin_collections: ["global"])
  end
  # alias_method :current_user, :current_user_dev if Rails.env.development?

  # Return boolean matching the url to find out if we are in the admin view
  def is_in_admin_view?
    !request.path.match("admin").nil?
  end
  helper_method :is_in_admin_view?

  ########
  # TODO
  # Is there a Rails way to do the following two functions?
  # sorted gem
  #
  # Protect against SQL injection by forcing column to be an actual column name in the model
  def sort_column klass, default_column = "title_sort"
    klass.constantize.column_names.include?(params[:sort]) ? params[:sort] : default_column
  end
  protected :sort_column

  # Protect against SQL injection by forcing direction to be valid
  def sort_direction default_direction = "asc"
    %w[asc desc].include?(params[:direction]) ? params[:direction] : default_direction
  end
  helper_method :sort_direction
  #
  ########

  # Load YAML file with repos info into Hash
  def repositories_info
    @repositories_info ||= YAML.load_file( File.join(Rails.root, "config", "repositories.yml") ).with_indifferent_access
  end
  helper_method :repositories_info

  # Return which Hash set to use
  #
  # * Return the Catalog repositories
  def repository_info
   return repositories_info["Catalog"]
  end
  helper_method :repository_info

  private

  def passive_login_url
    "#{ENV['PASSIVE_LOGIN_URL']}?client_id=#{ENV['APP_ID']}&return_uri=#{request_url_escaped}&login_path=#{login_path_escaped}"
  end

  def request_url_escaped
    CGI::escape(request.url)
  end

  def login_path_escaped
    CGI::escape("#{Rails.application.config.action_controller.relative_url_root}/login")
  end
end
