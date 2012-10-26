class Github < SyncClient
  def initialize
    @client = Octokit::Client.new(login: Settings.github.username, oauth_token: Settings.github.key)
  end

  def user
    cache :user
  end

  def repos
    cache :repos
  end

   private

  def fetch(params=nil)
    fresh_fetch_log params
    
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
