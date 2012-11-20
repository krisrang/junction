class TwitterClient < SyncClient
  def timeline
    cache_get
  end

  def sync
    cache_update
  end

  def valid?(result, params)
    result.is_a?(Array) && result[0].is_a?(Twitter::Tweet)
  end

  private

  def fetch(params=nil)
    Twitter.user_timeline count: 50
  end
end
