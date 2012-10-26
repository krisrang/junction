namespace :cache do
  desc "Clear Rails cache"
  task clear: :environment do
    puts "Clearing cache"
    Rails.cache.clear
  end
end
