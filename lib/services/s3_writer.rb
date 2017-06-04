require_relative 's3_service'
class S3Writer

  class InvalidFilename < StandardError; end
  class InvalidBucket < StandardError; end

  def initialize(bucket, filename)
    raise InvalidFilename.new("Filename is required") if filename.nil? || filename.empty?
    raise InvalidBucket.new("S3 Bucket name is required") if bucket.nil? || bucket.empty?
    @filename = filename
    @bucket = bucket
  end

  def write(contents)
    @client = S3Service.new(bucket: @bucket, region: ENV.fetch('AWS_REGION'))
    @client.put(@filename, contents)
  end
end
