class ApplicationController < ActionController::Base
  protect_from_forgery

  def set_expires
    expires_in 10.minutes, public: true
  end
end
