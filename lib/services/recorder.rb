# Record network speed

class Recorder

  def initialize( speedtest_bin: )
    @speedtest_bin = speedtest_bin
  end

  def execute
    `#{@speedtest_bin} --json`
  end

end
