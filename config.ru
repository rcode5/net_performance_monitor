# frozen_string_literal: true
require 'rubygems'
require 'sinatra'
disable :run

root = ::File.dirname(__FILE__)
require ::File.join(root, 'viewer')

# setup static serving
use Rack::Static, urls: ['/images', '/stylesheets', '/javascripts'], root: File.join(root, 'public')

run NetworkSpeedGrapher::Viewer.new
