class LastfmSync
  include HTTParty
  base_uri 'http://ws.audioscrobbler.com/2.0'
  
  # #parsed_response
  def tracks
    request("user.getrecenttracks")
  end

  # #parsed_response
  def user
    request("user.getinfo")
  end

  private

  def request(method)
    username = Settings.lastfm.username
    key = Settings.lastfm.key
    self.class.get("/?method=#{method}&user=#{username}&api_key=#{key}&format=json")
  end
end
