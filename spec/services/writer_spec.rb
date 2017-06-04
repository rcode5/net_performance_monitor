# frozen_string_literal: true
require 'fileutils'

require_relative '../spec_helper'
require_relative '../../lib/services/writer'

describe Writer do
  let(:type) { 'whatever' }
  let(:bucket) { nil }

  subject(:writer) { described_class.new(type, bucket: bucket) }
  describe '.write' do
    context 'when type is "file"' do
      let(:type) { 'file' }
      let(:testdir) { 'testdir' }
      after do
        FileUtils.rm_rf './testdir'
      end
      it 'writes the output to a file (and creates the directory if needed)' do
        expect(File.exist?(testdir)).to eq false
        writer.write(contents: 'stuff', filename: 'testing', directory: testdir)
        f = File.join(testdir, 'testing')
        expect(File.exist?(f)).to eq true
        expect(File.open(f).read).to eq 'stuff'
      end
    end

    context 'when type is "s3"' do
      let(:type) { 's3' }
      let(:bucket) { 'thebucket' }
      let(:testdir) { 'testdir' }
      before do
        @mock_writer = double(S3Writer, write: 'success')
        allow(S3Writer).to receive(:new).and_return(@mock_writer)
      end

      it 'writes the output to S3' do
        writer.write(contents: 'stuff', filename: 'testing', directory: testdir)
        f = File.join(testdir, 'testing')
        expect(S3Writer).to have_received(:new).with(bucket, f)
        expect(@mock_writer).to have_received(:write).with('stuff')
      end
    end

    context 'when type is not file or s3' do
      before do
        allow(STDOUT).to receive(:puts)
      end
      it 'writes the output to STDOUT' do
        writer.write(contents: 'stuff')
        expect(STDOUT).to have_received(:puts).with('stuff')
      end
    end
  end
end
