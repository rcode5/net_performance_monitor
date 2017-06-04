#!/usr/bin/env ruby
# frozen_string_literal: true

require 'fileutils'
require 'optparse'
require 'aws-sdk'

require_relative '../lib/services/recorder'
require_relative '../lib/services/writer'

SPEEDTEST = '/usr/local/bin/speedtest-cli'
DEFAULT_AWS_REGION = 'us-east-1'

output_filename = "speedtest_#{Time.now.to_i}.json"
class Options
  def self.build_summary(opts)
    opts.separator 'One time recording of the network speed using `speedtest-cli` which must'
    opts.separator 'be installed on your machine.  Results will be sent to STDOUT or to a file either'
    opts.separator 'locally or in an S3 Bucket (see option --output).'
    opts.separator ''
    opts.separator 'If the result is sent to a file, the filename will be #{output_filename} where the'
    opts.separator 'number is the current timestamp in seconds.'
    opts.separator ''
    opts.separator 'If you plan to use S3, please make sure you have set the following environment'
    opts.separator 'variables to allow access:'
    opts.separator '  AWS_ACCESS_KEY_ID'
    opts.separator '  AWS_SECRET_ACCESS_KEY'
    opts.separator '  AWS_BUCKET'
    opts.separator '  AWS_REGION'
    opts
  end

  def self.build_opts(opts, options)
    opts.on('-O', '--output OUTPUT', '"file" or "s3" to output results to a file, or a file on S3 (defaults to STDOUT)') do |output|
      options.output = output.downcase
    end

    opts.on('-d', '--directory [DIRECTORY]', 'Directory to put the file in') do |dir|
      options.directory = dir
    end

    opts.on('-b', '--bucket [BUCKET]', 'S3 bucket (if --output is "s3")') do |bucket|
      options.bucket = bucket
    end

    opts.on('-s', '--speedtest [SPEEDTEST_BINARY]', "speedtest binary file (default: #{SPEEDTEST}") do |speedtest|
      options.speedtest = speedtest
    end

    opts.on('-v', '--[no-]verbose', 'Run verbosely') do |v|
      options.verbose = v
    end

    opts.on_tail('-h', '--help', 'Show this message') do
      puts opts
      exit
    end
    options
  end

  def self.parse(args)
    options = OpenStruct.new(speedtest: SPEEDTEST, verbose: false)
    parser = OptionParser.new do |opts|
      opts.banner = "Usage: #{opts.program_name} [options]"
      opts.separator ''
      opts = build_summary(opts)
      opts.separator ''
      opts.separator 'Options:'
      options = build_opts(opts, options)
    end

    parser.parse!(args)
    options
  end
end

options = Options.parse(ARGV)

puts options.inspect
puts "Running speed test..."
result = Recorder.new(speedtest_bin: options.speedtest).execute
puts "Writing result..."
writer = Writer.new(options.output, bucket: options.bucket)
writer.write(contents: result, directory: options.directory, filename: output_filename)
