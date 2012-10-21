class InstagramSync
  include HTTParty
  base_uri 'https://api.instagram.com/v1'
  
  # #parsed_response
  def media
    request("media/recent/")
  end

  # #parsed_response
  def user
    request()
  end

  private

  def request(method="")
    username = Settings.instagram.access_id
    token = Settings.instagram.access_token
    self.class.get("/users/#{username}/#{method}?access_token=#{token}")
  end
end
