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

    client = Steam.new
    client.user
    client.games

    puts "Warming up caches"
    system "curl http://www.kristjanrang.eu &>/dev/null"
    system "curl http://www.kristjanrang.eu/modal/lastfm &>/dev/null"
    system "curl http://www.kristjanrang.eu/modal/github &>/dev/null"
    system "curl http://www.kristjanrang.eu/modal/instagram &>/dev/null"
    system "curl http://www.kristjanrang.eu/modal/twitter &>/dev/null"
    system "curl http://www.kristjanrang.eu/modal/foursquare &>/dev/null"
    system "curl http://www.kristjanrang.eu/modal/steam &>/dev/null"
  end
end
