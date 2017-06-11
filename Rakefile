# frozen_string_literal: true
require 'fileutils'

desc 'run the server'
task :run do |_t|
  require File.join(File.dirname(__FILE__), 'viewer.rb')
  NetworkSpeedGrapher::Viewer.run!
end

desc 'Clean'
task :clean do |_t|
  FileUtils.rm(Dir.glob('public/**/*.hot-update.*'), force: true);
  FileUtils.rm(Dir.glob('tmp/*'), force: true);
end

begin
  require 'rspec/core/rake_task'
  desc 'run specs'
  RSpec::Core::RakeTask.new
rescue Exception => ex
  puts "Exception: #{ex}"
  puts 'Failed to include RSpec rake tasks - should be ok for production environments'
end

Dir.glob('lib/tasks/*.rake').each { |r| import r }
