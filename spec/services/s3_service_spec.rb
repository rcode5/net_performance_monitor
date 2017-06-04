# frozen_string_literal: true
require_relative '../spec_helper'

require_relative '../../lib/services/s3_service'
describe S3Service do

  subject(:service) { described_class.new(bucket: 'my bucket', region: 'my region') }

  subject(:aws_responses) {
    [
      double('AwsResponse', contents: [
               double('S3Object', key: 'a'),
               double('S3Object', key: 'b')
             ]),
      double('AwsResponse', contents: [
               double('S3Object', key: 'c')
             ])
    ]
  }

  before do
    stub_const('ENV', {'AWS_ACCESS_KEY_ID' => 'bogus', 'AWS_SECRET_ACCESS_KEY' => 'secret'})
    mock_object = double( Aws::S3::Object, body: StringIO.new("body contents") )
    @mock_s3_client = double(Aws::S3::Client,
                            list_objects: aws_responses,
                            get_object: mock_object,
                            put_object: 'put')

    allow(Aws::S3::Client).to receive(:new).and_return(@mock_s3_client)
  end
  describe '.files' do
    it 'retrieves a list of files from s3' do
      expect(service.files).to eql %w( a b c )
      expect(@mock_s3_client).to have_received(:list_objects).with(bucket: 'my bucket')
    end
  end

  describe '.get_contents' do
    it 'retrieves the file contents from s3' do
      expect(service.get('whatever')).to eql 'body contents'
      expect(@mock_s3_client).to have_received(:get_object).with(bucket: 'my bucket', key: 'whatever')
    end
  end

  describe '.put_contents' do
    it 'writes a file to s3' do
      expect(service.put('filename', 'whatever')).to eql 'put'
      expect(@mock_s3_client).to have_received(:put_object).with(bucket: 'my bucket', key: 'filename', body: 'whatever')
    end
  end

end
