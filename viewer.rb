# frozen_string_literal: true
begin
  require 'byebug'
rescue LoadError => ex
  puts 'Failed to load some development gems.'
  puts ex
end

require 'sinatra'
#require 'sinatra/static_assets'
require_relative 'lib/app/api'

# require 'sinatra/contrib'
require 'json'

ROOT_DIR = File.dirname(__FILE__)

Dir.glob(File.join(ROOT_DIR, 'lib/services/*.rb')).each { |f| require f }

module NetworkSpeedGrapher
  class Viewer < Sinatra::Base

    set :public_folder, 'public'

    include NetworkSpeedGrapher::Api
    #register Sinatra::StaticAssets

    set :environment, :production
    set :logging, true
    set :root, ROOT_DIR
    APP_ROOT = root

    def s3
      @s3 ||= S3Service.new bucket: ENV.fetch('AWS_BUCKET'), region: ENV.fetch('AWS_REGION')
    end

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
      redirect '/index.html'
    end

  end

end
