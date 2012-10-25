# Load pow environment variables into development and test environments
if FileTest.exist?(".powenv")
  begin
    # read contents of .powenv
    powenv = File.open(".powenv", "rb")
    contents = powenv.read
    # parse content and retrieve variables from file
    lines = contents.gsub("export ", "").split(/\n\r?/).reject{|line| line.blank?}
    lines.each do |line|
      key = line.split("=", 2)
      next unless key.count == 2
      # set environment variable set in .powenv
      ENV[key.first] = key.last.gsub("'",'').gsub('"','')
    end
    # close file pointer
    powenv.close
  rescue => _
  end
end

# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Junction::Application.initialize!
