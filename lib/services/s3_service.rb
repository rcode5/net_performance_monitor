# frozen_string_literal: true
require 'aws-sdk'

class S3Service
  def initialize(bucket:, region:)
    @region = region
    @bucket = bucket
    @client = Aws::S3::Client.new(region: @region, credentials: credentials)
  end

  def files
    @files = []

    @client.list_objects(s3_params).each do |resp|
      @files << resp.contents.map(&:key)
    end

    @files.uniq.flatten
  end

  def get(key)
    get_object(key).body.read
  end

  def put(fname, contents)
    @client.put_object(s3_params(key: fname, body: contents))
  end

  private

  def get_object(key)
    @client.get_object(s3_params(key: key))
  end

  def s3_params(options = nil)
    { bucket: @bucket }.merge(options || {})
  end

  def credentials
    @credentials ||= Aws::Credentials.new(
      ENV.fetch('AWS_ACCESS_KEY_ID'),
      ENV.fetch('AWS_SECRET_ACCESS_KEY')
    )
  end
end
