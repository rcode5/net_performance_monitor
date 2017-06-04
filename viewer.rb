# frozen_string_literal: true
begin
  require 'byebug'
rescue LoadError => ex
  puts 'Failed to load some development gems.'
  puts ex
end

require 'sinatra'
# require 'sinatra/static_assets'
require 'sinatra/contrib'
require 'json'

class Viewer < Sinatra::Base
  register Sinatra::StaticAssets

  set :environment, :production
  set :logging, true
  set :root, File.dirname(__FILE__)
  APP_ROOT = root

  helpers do
    def protected!
      return if authorized?
      response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
      throw(:halt, [401, "Not authorized\n"])
    end

    def authorized?
      @auth ||= Rack::Auth::Basic::Request.new(request.env)
      user = ENV['BASIC_AUTH_USER'] || gen_random_string
      pass = ENV['BASIC_AUTH_PASS'] || gen_random_string
      @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == [user, pass]
    end
  end

  get '/' do
    @title = 'Network Report'
  end
end
