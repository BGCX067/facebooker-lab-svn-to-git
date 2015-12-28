# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery :secret => '7ae09bb01c333362c25933ad28456482'
  ensure_authenticated_to_facebook
  
  helper_attr :current_user 
  attr_accessor :current_user 
  before_filter :set_current_user
  
  def create_user
    User.for(facebook_session.user.to_i)
  end
  
  def set_current_user
    set_facebook_session
    self.current_user = User.for(facebook_session.user.to_i, facebook_session)
  end
end
