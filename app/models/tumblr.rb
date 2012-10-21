class Tumblr
  include HTTParty
  base_uri 'https://api.tumblr.com'

  def posts
    fetch "posts"
  end

  def tag(tag)
    fetch "tag-#{tag}", "&tag=#{tag}"
  end

  def post(id)
    fetch id, "&id=#{id}"
  end

  private 

  def fetch(type, params=nil)
    hash = Rails.cache.fetch("tumblr-#{type}", expires_in: 10.minutes) do
      r = query(params)

      r.response.code.to_s == "200" && r.parsed_response.is_a?(Hash) ?
        r.parsed_response["response"] :
        {posts: []}
    end
    
    Hashie::Mash.new(hash).posts
  end

  def query(params=nil)
    blog = Settings.tumblr.blog
    key = Settings.tumblr.key
    self.class.get("/v2/blog/#{blog}/posts?api_key=#{key}&offset=0#{params}")
  end
end
