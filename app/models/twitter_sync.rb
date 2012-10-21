class TwitterSync

  # [Twitter::Tweet]
  def timeline
    Twitter.user_timeline count: 50
  end
end
