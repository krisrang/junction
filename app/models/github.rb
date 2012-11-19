class Github < SyncClient
  def initialize
    @client = Octokit::Client.new(login: Settings.github.username, oauth_token: Settings.github.key)
  end

  def user
    cache_get :user
  end

  def repos
    cache_get :repos
  end

  def sync
    cache_update :user
    cache_update :repos
  end

  def valid?(result, params)
    case params
    when :user
      result.is_a?(Hashie::Mash) && result.has_key?("type") && result.type.downcase == "user"
    when :repos
      result.is_a?(Array) && result[0].is_a?(Hashie::Mash) && result[0].has_key?("url")
    end
  end

  private

  def fetch(params=nil)
    case params
    when :user
      @client.user
    when :repos
      @client.repositories.map do |repo|
        repo.created_at = DateTime.parse(repo.created_at)
        repo.updated_at = DateTime.parse(repo.updated_at)
        repo.pushed_at = DateTime.parse(repo.pushed_at)
        repo
      end
    end
  end
end
