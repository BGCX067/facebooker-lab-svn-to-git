class User < ActiveRecord::Base
  def self.for(facebook_id, facebook_session = nil)
    returning find_or_create_by_facebook_id(facebook_id) do |user|
      unless facebook_session.nil?
        user.store_session(facebook_session.session_key)
      end
    end
  end
  
  def store_session(session_key)
    if self.session_key != session_key
      update_attribute(:session_key, session_key)
    end
  end
  
  def facebook_session
    @facebook_session ||=
      returning Facebooker::Session.create do |session|
        session.secure_with!(session_key, facebook_id, 1.hour.from_now)
    end
  end  
end
