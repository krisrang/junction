class Foursquare
  def initialize
    @client = Foursquare2::Client.new(oauth_token: Settings.foursquare.access_token)
  end
  
  def user
    @client.user('self')
  end

  def checkins
    @client.user_checkins limit: 10
  end
end
