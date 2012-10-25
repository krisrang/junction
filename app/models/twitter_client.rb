class TwitterClient
  def self.timeline
    Twitter.user_timeline count: 50
  end
end
