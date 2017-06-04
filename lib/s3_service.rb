require 'aws-sdk'

class S3Service

  DEFAULT_BUCKET = 'net-performance'

  attr_reader :bucket

  def initialize(bucket: nil)
    @client = Aws::S3::Client.new(region: region, credentials: credentials)
    @bucket = bucket || DEFAULT_BUCKET
  end

  def files
    @files = []

    @client.list_objects(bucket: bucket).each do |resp|
      @files << resp.contents.map(&:key)
    end

    @files.uniq.flatten
  end

  def region
    ENV.fetch('AWS_REGION', 'us-east-1')
  end

  def credentials
    @credentials ||= Aws::Credentials.new(
      ENV.fetch('AWS_ACCESS_KEY_ID'),
      ENV.fetch('AWS_SECRET_ACCESS_KEY'))
  end

end
