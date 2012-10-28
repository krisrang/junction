class Lastfm < SyncClient
  include HTTParty
  base_uri 'http://ws.audioscrobbler.com/2.0'

  METHODS = {
    user: "user.getinfo",
    tracks: "user.getrecenttracks"
  }
  
  def tracks
    cache :tracks
  end

  def user
    cache :user
  end

  private
  
  def fetch(method=nil)
    fresh_fetch_log method

    params = METHODS[method]
    r = query(params)

    hash = r.response.code.to_s == "200" && r.parsed_response.is_a?(Hash) ?
        r.parsed_response :
        {}

    if method == :user
      Hashie::Mash.new(hash["user"]).tap do |user|
        user.registered = Time.at(user.registered.unixtime.to_i)
      end
    elsif method == :tracks
      Hashie::Mash.new(hash["recenttracks"]).tap do |tracks|
        (tracks.track || []).map do |track|
          track.date = track.date ? 
            Time.at(track.date.uts.to_i).utc : 
            Time.now.utc
        end
      end
    end
  end

  def query(method)
    username = Settings.lastfm.username
    key = Settings.lastfm.key
    self.class.get("/?method=#{method}&user=#{username}&api_key=#{key}&format=json")
  end
end
