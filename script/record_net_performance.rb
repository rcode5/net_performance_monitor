#!/usr/bin/env ruby
# frozen_string_literal: true

require 'fileutils'
require 'optparse'
require 'aws-sdk'

SPEEDTEST = 'speedtest-cli'
OUTPUT_DIRECTORY = 'net_performance'

output_filename = "speedtest_#{Time.now.to_i}.json"
class Options
  def self.build_summary(opts)
    opts.separator 'One time recording of the network speed using `speedtest-cli` which must'
    opts.separator 'be installed on your machine.  Results will be saved to a file either'
    opts.separator 'locally or in an S3 Bucket (see option --s3).'
    opts.separator ''
    opts.separator 'If you plan to use S3, please make sure you have set the following environment'
    opts.separator 'variables to allow access:'
    opts.separator '  AWS_ACCESS_KEY_ID'
    opts.separator '  AWS_SECRET_ACCESS_KEY'
    opts.separator '  AWS_BUCKET'
    opts.separator "  AWS_REGION (default #{DEFAULT_AWS_REGION}"
    opts
  end

  def self.build_opts(opts)
    opts.on('-s', '--s3', 'Put results on S3') do |s3|
      options.s3 = s3
    end

    opts.on('-v', '--[no-]verbose', 'Run verbosely') do |v|
      options.verbose = v
    end

    opts.on_tail('-h', '--help', 'Show this message') do
      puts opts
      exit
    end
    opts
  end

  def self.parse(args)
    options = OpenStruct.new(s3: false, path_to_speed_test: '/usr/local/bin', verbose: false)
    parser = OptionParser.new do |opts|
      opts.banner = "Usage: #{opts.program_name} [options]"
      opts.separator ''
      opts = build_summary(opts)
      opts.separator ''
      opts.separator 'Options:'
      build_opts(opts)
    end

    parser.parse!(args)
    options
  end
  # rubocop:enable Metrics/AbcSize
end

options = Options.parse(ARGV)
pp options

# puts "Running speed test..."
# result = `#{SPEEDTEST} --json`
# puts "Writing result to #{outfile}"
# fp = File.open(outfile,'w')
# fp.write(result)
# fp.close
