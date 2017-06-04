require 'rubygems'
require 'sinatra'
disable :run

root = ::File.dirname(__FILE__)
require ::File.join( root, 'viewer' )

# setup static serving
use Rack::Static, :urls => [ "/images", "/stylesheets", "/javascripts"], :root => File.join(root, 'public')

Paperclip.configure do |config|
  config.root               = root # the application root to anchor relative urls (defaults to Dir.pwd)
  config.env                = ENV['RACK_ENV'] || 'development'  # server env support, defaults to ENV['RACK_ENV'] or 'development'
end

run Viewer.new

