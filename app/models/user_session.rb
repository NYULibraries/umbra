class UserSession < Authlogic::Session::Base
  pds_url ENV['PDS_URL']
  calling_system ENV['PDS_CALLING_SYSTEM']
  anonymous true

  def additional_attributes
    h = {}
    return h unless pds_user
    h[:umbra_admin], h[:umbra_admin_collections] = true, ["global"] if ENV['PDS_ADMINS'].present? && ENV['PDS_ADMINS'].include?(pds_user.uid)
    return h
  end

  def attempt_sso?
    return false if Rails.env.test?
  end
end
