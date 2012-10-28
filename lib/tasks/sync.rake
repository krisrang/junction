namespace :sync do
  desc "Update syncs"
  task update: :environment do
    puts "Updating posts"
    Post.sync

    puts "Clearing cache"
    Rails.cache.clear

    puts "Prefetching 3rd party data"
    client = Lastfm.new
    client.user
    client.tracks

    client = Github.new
    client.user
    client.repos

    client = Instagram.new
    client.user
    client.media

    TwitterClient.new.timeline

    client = Foursquare.new
    client.user
    client.checkins
  end
end
