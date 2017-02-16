require_relative 'repositories'
module Umbra
  module Collections
    extend ActiveSupport::Concern
    include Umbra::Repositories

    def admin_collections_name
      "umbra_admin_collections".to_sym
    end

    # Get an array of collections authorized to the current logged in user from user attributes
    #
    # * Return an empty array if user has global access, this will skip loop adding collections to solr search hence showing all
    # * If not a global admin return array of collections to add to any_of loop to solr params
    # * If the user has no access to specific collections and no global flag return an array containing nil
    #   This will add the nil collection to the search which will return nothing
    def current_user_admin_collections
      if current_user.has_admin_collections?
        if current_user.has_global_collection?
          []
        else
          current_user.admin_collections
        end
      else
        return [nil]
      end
    end
    private :current_user_admin_collections

    # Find out if current_user has access to collection
    #
    # * True if current_user's admin collections is empty, this means the "global" flag is set
    # * True if collection is included in current_user's list of collection
    # * False otherwise
    def current_user_has_access_to_collection(collection)
      (current_user_admin_collections.empty? or current_user_admin_collections.include? collection)
    end
    private :current_user_has_access_to_collection
    alias_method :current_user_has_access_to_collection?, :current_user_has_access_to_collection

    # Edit authorized collection list based on submitted values
    def update_admin_collections
      @user = User.find(params[:id])
      unless params[:user][self.admin_collections_name].blank?
        # Loop through all submitted admin collections
        params[:user][self.admin_collections_name].keys.each do |collection|
          update_admin_collection(collection)
        end
      end
    end
    private :update_admin_collections

    def update_admin_collection(collection)
      if collection_unselected?(collection)
        @user.user_collections.delete(collection)
      elsif !@user.user_collections.include? collection
        @user.user_collections.push(collection)
      end
    end
    private :update_admin_collection

    def collection_selected?(collection)
      params[:user][self.admin_collections_name][collection].to_i == 1 rescue false
    end
    private :collection_selected?

    def collection_unselected?(collection)
      !collection_selected?(collection)
    end
    private :collection_unselected?

    # Return which collections this admin user is authorized to view and edit
    #
    # If no collections have been set for this user return an empty array.
    def collections_user_can_admin
      return [] if @user.admin_collections.nil? or !@user.admin_collections.is_a? Array
      return @user.admin_collections
    end

    # Get the current collection code
    def current_collection(collection_name)
      @current_collection ||= get_repository_admin_code(collection_name) unless collection_name.nil?
    end

    # Sets a session variable to the user submitted collection
    def set_session_collection
      # This redirect hijacks the "Start over" function to redirect back to the correct collection instead of the generic catalog
      redirect_to("/#{session[:collection]}") if redirect_to_session_url?
      # Set session variable to local param
      # Don't set it to nil though because we don't want it to default to "all collections"
      session[:collection] = params[:collection] if params[:collection].present?
    end

    def redirect_to_session_url?
      params[:collection].blank? && session[:collection].present? && request.path == "/catalog"
    end
    private :redirect_to_session_url?

    # Add the session collection to the list of submitted variables
    def add_collection_param_to_search
      # Merge collection with params only if the controller is catalog,
      # because Bookmarks extends Catalog we need this fix
      params.merge!({:collection => session[:collection]}) if controller_name == "catalog"
    end

    # Get the name of the collection from the tab info, or default to blank
    #
    # * If the collection session variable was set, use that to get the collection display name from yaml
    # * If there is a current collection otherwise, use that
    # * Show blank if no collection
    def collection_name
      if (session[:collection])
        get_repository_display(session[:collection])
      elsif current_collection(params[:collection]).present?
        get_repository_display(params[:collection])
      else
        ""
      end
    end

    # Collect collections admin code from YAML
    def collection_codes
      @collections ||= repositories.collect{|c| c[1]["admin_code"] }.push("global")
    end

  end
end
