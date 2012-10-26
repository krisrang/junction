class ApplicationController < ActionController::Base
  protect_from_forgery

  def set_expires
    expires_in 10.minutes, 'max-stale' => 1.hour, public: true
  end

  def freshness_options(date)
    {last_modified: date, public: true}
  end
end
