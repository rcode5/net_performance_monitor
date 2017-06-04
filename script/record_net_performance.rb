#!/usr/bin/env ruby

require 'fileutils'

SPEEDTEST='speedtest-cli'

outdir = "#{ENV['HOME']}/net_performance"
outfile = File.join(outdir, "speedtest_#{Time.now.to_i}.json")

FileUtils::mkdir_p(outdir)

puts "Running speed test..."
result = `#{SPEEDTEST} --json`
puts "Writing result to #{outfile}"
fp = File.open(outfile,'w')
fp.write(result)
fp.close
