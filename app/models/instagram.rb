class Instagram < SyncClient
  include HTTParty
  base_uri 'https://api.instagram.com/v1'
  
  PATHS = {
    user: "",
    media: "media/recent/"
  }

  def media
    cache_get :media
  end

  def user
    cache_get :user
  end

  def sync
    cache_update :user
    cache_update :media
  end

  def valid?(result, params)
    case params
    when :user
      result.is_a?(Hashie::Mash) && result.has_key?("username")
    when :media
      result.is_a?(Array) && result[0].is_a?(Array) && 
      result[0][0].is_a?(Hashie::Mash) && result[0][0].has_key?("location")
    end
  end

  private

  def fetch(method=nil)
    path = PATHS[method]
    r = query(path)

    hash = r.response.code.to_s == "200" && r.parsed_response.is_a?(Hash) ?
        r.parsed_response :
        {"data" => {}}

    if method == :user
      Hashie::Mash.new(hash["data"]).tap do |user|
        #user.registered = Time.at(user.registered.unixtime.to_i)
      end
    elsif method == :media
      pagination = Hashie::Mash.new(hash["pagination"])
      media = (hash["data"] || []).map do |media|
        Hashie::Mash.new(media).tap do |image|
          image.date = Time.at(image.created_time.to_i).utc
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
