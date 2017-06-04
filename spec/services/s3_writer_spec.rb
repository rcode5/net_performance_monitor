# frozen_string_literal: true
require_relative '../spec_helper'
require_relative '../../lib/services/s3_writer'

describe S3Writer do
  let(:bucket) { 'thebucket' }
  let(:region) { 'theregion' }
  let(:filename) { 'filename' }

  subject(:service) { described_class.new(bucket, filename) }

  before do
    stub_const('ENV', 'AWS_REGION' => region)
  end

  describe '.new' do
    it 'requires bucket and filename' do
      expect { described_class.new(nil, nil) }.to raise_error S3Writer::InvalidFilename
      expect { described_class.new(nil, 'file') }.to raise_error S3Writer::InvalidBucket
      expect { described_class.new('', '') }.to raise_error S3Writer::InvalidFilename
      expect { described_class.new('', 'file') }.to raise_error S3Writer::InvalidBucket
    end
  end

  describe '.write' do
    let(:mock_service) do
      double(S3Service, put: 'success')
    end
    before do
      allow(S3Service).to receive(:new).and_return(mock_service)
    end
    it 'writes the contents to s3' do
      expect(service.write('the contents')).to eql 'success'
      expect(S3Service).to have_received(:new).with(bucket: bucket, region: region)
      expect(mock_service).to have_received(:put).with(filename, 'the contents')
    end
  end
end
