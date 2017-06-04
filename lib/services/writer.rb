# frozen_string_literal: true
require 'fileutils'
require_relative 'file_writer'
require_relative 's3_writer'

require 'byebug'

class Writer
  def initialize(type, bucket: nil)
    @type = type
    @bucket = bucket
  end

  def write(contents:, filename: nil, directory: nil)
    case @type
    when 'file'
      fname = filename
      if directory
        FileUtils.mkdir_p(directory)
        fname = File.join(directory, filename)
      end
      FileWriter.new(fname).write(contents)
    when 's3'
      fname = filename
      fname = File.join(directory, filename) if directory
      S3Writer.new(@bucket, fname).write(contents)
    else
      puts contents
    end
  end
end
