class User < ActiveRecord::Base
  # Connects this user object to Blacklights Bookmarks and Folders.
  include Blacklight::User
  # Login with NYULibraris OAuth provider
  devise :omniauthable, omniauth_providers: [:nyulibraries]

  scope :non_admin, -> { where.not(admin: true) }

  serialize :admin_collections

  acts_as_indexed fields: [:firstname, :lastname, :username, :email]

  # Create a CSV format
  comma do
    username
    firstname
    lastname
    email
  end

  def has_admin_collections?
    self.admin_collections? rescue false
  end

  def has_global_collection?
    self.admin_collections.include? "global" rescue false
  end

  # Get user collections for @user instance, cast as Array if necessary
  def user_collections
    @user_collections ||= (self.admin_collections.nil?) ? [] :
                            (self.admin_collections.is_a? Array) ?
                              self.admin_collections : [self.admin_collections]
  end

end
