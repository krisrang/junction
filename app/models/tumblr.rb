class Tumblr
  include HTTParty
  base_uri 'https://api.tumblr.com'

  def posts
    fetch
  end

  private

  def fetch
    r = query

    return false unless r.response.code.to_s == "200" && r.parsed_response.is_a?(Hash)

    hash = r.parsed_response["response"]

    (hash["posts"] || []).map do |post|
      Hashie::Mash.new(post).tap do |p|
        p.date = Time.at(p.timestamp)
        p.title = p.title.blank? ? nil : p.title
      end
    end
  end

  def query
    blog = Settings.tumblr.blog
    key = Settings.tumblr.key
    self.class.get("/v2/blog/#{blog}/posts?api_key=#{key}&offset=0")
  end
end
