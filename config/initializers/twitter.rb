Twitter.configure do |config|
  config.consumer_key = Settings.twitter.key
  config.consumer_secret = Settings.twitter.secret
  config.oauth_token = Settings.twitter.access_key
  config.oauth_token_secret = Settings.twitter.access_secret
end
