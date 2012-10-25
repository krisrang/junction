class Tumblr
  include HTTParty
  base_uri 'https://api.tumblr.com'

  def posts
    fetch
  end

  def tag(tag)
    tag = CGI.escape tag
    fetch "&tag=#{tag}"
  end

  def post(id)
    fetch "&id=#{id}"
  end

  private 

  def fetch(params=nil)
    r = query(params)

    hash = r.response.code.to_s == "200" && r.parsed_response.is_a?(Hash) ?
      r.parsed_response["response"] :
      {"posts" => []}

    hash["posts"].map do |post|
      Hashie::Mash.new(post).tap do |p|
        p.date = Time.at(p.timestamp)
        p.title = p.title.blank? ? nil : p.title
      end
    end
  end

  def query(params=nil)
    blog = Settings.tumblr.blog
    key = Settings.tumblr.key
    self.class.get("/v2/blog/#{blog}/posts?api_key=#{key}&offset=0#{params}")
  end
end
