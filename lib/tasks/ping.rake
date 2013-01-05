namespace :ping do
  desc "Ping all sites"
  task :sites do
    system "curl -I http://www.kristjanrang.eu/"
    system "curl -I http://forum.kristjanrang.eu/"
  end
end
