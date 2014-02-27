class NetRC

  attr_accessor :token, :user
  def initialize
    #Check if there is a .netrc file to read from
    if File.exists?("#{ENV['HOME']}/.netrc")
      puts "Success? #{parseToken("#{ENV['HOME']}/.netrc")}"
    else
      #create the .netrc file in home directory
      # new_file = File.new("#{ENV['HOME']}/.netrc", "w")
      # generateToken(new_file)
      # new_file.close
    end

  end

  def parseToken (path)
    begin
      f = File.open("#{path}", "r")
      netRCPattern = %r[(machine github.com) (\S+) (\S+)]
      tokenPattern = %r[.{40}]
      githubLine = f.each_line.select{|line|line.match(netRCPattern)}
      values = githubLine.first.split(" ")
      @user = values[2]
      @token = values[3] if (values[3].index(tokenPattern))
      f.close
      true
    rescue
      false
    end
  end

  #need to prompt for user
  def generateToken (file)
    file.puts("machine github.com login ")
  end

  def has_token?
    return !@token.nil? && @token.length==40
  end
end
