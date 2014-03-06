class User < ActiveRecord::Base
  # Connects this user object to Blacklights Bookmarks and Folders. 
  include Blacklight::User
  attr_accessible :crypted_password, :current_login_at, :current_login_ip, :email, :firstname, :last_login_at, :last_login_ip, :last_request_at, :lastname, :login_count, :mobile_phone, :password_salt, :persistence_token, :refreshed_at, :session_id, :user_attributes, :username

  serialize :user_attributes  

  acts_as_authentic do |c|
    c.validations_scope = :username
    c.validate_password_field = false
    c.require_password_confirmation = false  
    c.disable_perishable_token_maintenance = true
  end
  
  # This search logic function protected against SQL injection
  def self.search(search)
    if search
      q = "%#{search}%"
      where('firstname LIKE ? || lastname LIKE ? || username LIKE ? || email LIKE ?', q, q, q, q)
    else
      # scoped to send back an ActiveRelation
      scoped
    end
  end
  
  # Create a CSV format
  comma do
    username
    firstname
    lastname
    email
  end
  
  def has_admin_collections?
    (self.try(:user_attributes)[admin_collections_name].present?) rescue false
  end
  
  def has_global_collection?
    self.try(:user_attributes)[admin_collections_name].include? "global" rescue false
  end
  
  # Get user collections for @user instance, cast as Array if necessary
  def user_collections
    @user_collections ||= (self.user_attributes[admin_collections_name].nil?) ? [] : 
                            (self.user_attributes[admin_collections_name].is_a? Array) ? 
                              self.user_attributes[admin_collections_name] : [self.user_attributes[admin_collections_name]]
  end
  
  def admin_collections_name
    "umbra_admin_collections".to_sym
  end

end
