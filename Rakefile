desc 'run the server'
task :run do |t|
  require File.join(File.dirname(__FILE__),'viewer.rp')
  Viewer.run!
end

begin
  require 'rspec/core/rake_task'
  desc "run specs"
  RSpec::Core::RakeTask.new
rescue Exception => ex
  puts "Failed to include RSpec rake tasks - should be ok for production environments"
end
