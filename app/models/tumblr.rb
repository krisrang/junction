class Tumblr
  include HTTParty
  base_uri 'https://api.tumblr.com'

  def self.query
    hash = Rails.cache.fetch("tumblr", expires_in: 10.minutes) do
      r = self.new.get_posts

      r.response.code.to_s == "200" && r.parsed_response.is_a?(Hash) ?
        r.parsed_response["response"] :
        {posts: []}
    end
    
    Hashie::Mash.new hash
  end

  def get_posts
    blog = Settings.tumblr.blog
    key = Settings.tumblr.key
    self.class.get("/v2/blog/#{blog}/posts?api_key=#{key}&offset=0")
  end
end
