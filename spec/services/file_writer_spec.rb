# frozen_string_literal: true
require_relative '../spec_helper'
require_relative '../../lib/services/file_writer'

require 'fileutils'
require 'tempfile'

describe FileWriter do
  let(:filename) { Tempfile.new.path }

  subject(:service) { described_class.new(filename) }

  describe '.new' do
    it 'requires filename' do
      expect { described_class.new(nil) }.to raise_error FileWriter::InvalidFilename
      expect { described_class.new('') }.to raise_error FileWriter::InvalidFilename
    end
  end

  describe '.write' do
    it 'writes the contents to s3' do
      service.write('the contents')
      expect(File.open(filename).read).to eql 'the contents'
      FileUtils.rm filename, force: true
    end
  end
end
