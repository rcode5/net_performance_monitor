# frozen_string_literal: true
begin
  require 'byebug'
rescue LoadError => ex
  puts 'Failed to load some development gems.'
  puts ex
end

require 'sinatra'
# require 'sinatra/static_assets'
# require 'sinatra/contrib'
require 'json'

ROOT_DIR = File.dirname(__FILE__)

Dir.glob(File.join(ROOT_DIR, 'lib/services/*.rb')).each { |f| require f }

class Viewer < Sinatra::Base
  # register Sinatra::StaticAssets

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
    @title = 'Network Report'
    s3_client = S3Service.new bucket: ENV.fetch('AWS_BUCKET'), region: ENV.fetch('AWS_REGION')
    @files = s3_client.files.map { |f| "<li><a href='/file/#{f}'>#{f}</a></li>" }.join
    "<ul>#{@files}</ul>"
  end

  get '/files/' do
    content_type :json
    @title = 'Network Report'
    s3.files.to_json
  end

  get '/file/*' do
    content_type :json
    s3.get(params[:splat].first)
  end
end
