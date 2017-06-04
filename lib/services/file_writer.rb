class FileWriter

  class InvalidFilename < StandardError; end

  def initialize(filename)
    raise InvalidFilename.new("Filename is required") if filename.nil? || filename.empty?
    @filename = filename
  end

  def write(contents)
    fp = File.open(@filename, 'w')
    fp.write(contents)
    fp.close
  end
end
