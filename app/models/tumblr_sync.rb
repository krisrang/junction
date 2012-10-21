class TumblrSync
  include HTTParty
  base_uri 'https://api.tumblr.com'
  
  # #parsed_response
  def posts
    blog = Settings.tumblr.blog
    key = Settings.tumblr.key
    self.class.get("/v2/blog/#{blog}/posts?api_key=#{key}&offset=0")
  end
end
