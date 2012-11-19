namespace :sync do
  desc "Update syncs"
  task update: :environment do
    puts "Updating posts"
    Post.sync

    puts "Syncing 3rd party data"
    Lastfm.new.sync
    Github.new.sync
    Instagram.new.sync
    TwitterClient.new.sync
    Foursquare.new.sync
    Steam.new.sync

    puts "Done"
  end
end
