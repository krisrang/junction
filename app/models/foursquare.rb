class Foursquare < SyncClient
  def initialize
    @client = Foursquare2::Client.new(oauth_token: Settings.foursquare.access_token)
  end
  
  def user
    cache_get :user
  end

  def checkins
    cache_get :checkins
  end

  def sync
    cache_update :user
    cache_update :checkins
  end

  def valid?(result, params)
    case params
    when :user
      result.is_a?(Hashie::Mash) && result.has_key?("id")
    when :checkins
      result.is_a?(Array) && result[0].is_a?(Hashie::Mash) && result[0].has_key?("id")
    end
  end

  private

  def fetch(params=nil)
    case params
    when :user
      @client.user('self')
    when :checkins
      @client.user_checkins(limit: 10).items.map do |checkin|
        checkin.date = Time.at(checkin.createdAt).utc
        checkin
      end
    end
  end
end
