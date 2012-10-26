class Foursquare < SyncClient
  client_name 'foursquare'

  def initialize
    @client = Foursquare2::Client.new(oauth_token: Settings.foursquare.access_token)
  end
  
  def user
    cache :user
  end

  def checkins
    cache :checkins
  end

  private

  def fetch(params=nil)
    fresh_fetch_log params
    
    case params
    when :user
      @client.user('self')
    when :checkins
      @client.user_checkins(limit: 10).items.map do |checkin|
        checkin.date = Time.at(checkin.createdAt)
        checkin
      end
    end
  end
end
