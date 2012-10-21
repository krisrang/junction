class GithubSync
  def initialize
    @client = Octokit::Client.new(login: Settings.github.username, oauth_token: Settings.github.key)
  end

  def user
    @client.user
  end

  def repos
    @client.repositories
  end
end
