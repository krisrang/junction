class Instagram < SyncClient
  include HTTParty
  base_uri 'https://api.instagram.com/v1'
  
  PATHS = {
    user: "",
    media: "media/recent/"
  }

  def media
    cache :media
  end

  def user
    cache :user
  end

  private

  def fetch(method=nil)
    fresh_fetch_log method

    path = PATHS[method]
    r = query(path)

    hash = r.response.code.to_s == "200" && r.parsed_response.is_a?(Hash) ?
        r.parsed_response :
        {"date" => {}}

    if method == :user
      Hashie::Mash.new(hash["data"]).tap do |user|
        #user.registered = Time.at(user.registered.unixtime.to_i)
      end
    elsif method == :media
      pagination = Hashie::Mash.new(hash["pagination"])
      media = (hash["data"] || []).map do |media|
        Hashie::Mash.new(media).tap do |image|
          image.date = Time.at(image.created_time.to_i)
        end
      end
      [media, pagination]
    end
  end

  def query(path=nil)
    username = Settings.instagram.access_id
    token = Settings.instagram.access_token
    self.class.get("/users/#{username}/#{path}?access_token=#{token}")
  end
end
