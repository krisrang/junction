class TwitterClient < SyncClient
  def timeline
    cache
  end

  private

  def fetch(params=nil)
    fresh_fetch_log
    Twitter.user_timeline count: 50
  end
end
