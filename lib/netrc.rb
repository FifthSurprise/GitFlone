class NetRC

  attr_accessor :token
  def initialize
    #Check if there is a .netrc file to read from
    if File.exists?("#{ENV['HOME']}/.netrc")
      puts "Success? #{parseToken("#{ENV['HOME']}/.netrc")}"
      puts @token
    else
      #create the .netrc file in home directory
      new_file = File.new("#{ENV['HOME']}/.netrc", "w")
      generateToken(new_file)
      new_file.close
    end

  end

  def parseToken (path)
    begin
      f = File.open("#{path}", "r")
      netRCPattern = %r[(machine github.com login).+]
      tokenPattern = %r[(?<=login ).{40}]
      githubLine = f.each_line.select{|line|line.match(netRCPattern)}
      @token = githubLine.first.scan(tokenPattern).first
      f.close
      true
    rescue
      false
    end
  end

  def generateToken (file)

    file.puts("machine github.com login ")
  end

  def has_token?
    return @token.length==40
  end
end

n = NetRC.new
