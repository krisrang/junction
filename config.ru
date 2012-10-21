require ::File.expand_path('../config/environment',  __FILE__)
use Rack::Deflater # If assets are being served locally this will also gzip images etc
run Junction::Application
