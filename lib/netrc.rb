class NetRC

  attr_accessor :token, :user
  def initialize
    #Check if there is a .netrc file to read from
    if File.exists?("#{ENV['HOME']}/.netrc")
      puts "Success? #{parseToken("#{ENV['HOME']}/.netrc")}"
    else
      #create the .netrc file in home directory
      puts "Creating a .netrc file for you in #{ENV['HOME']}"
      new_file = File.new("#{ENV['HOME']}/.netrc", "a")
      generateToken(new_file)
      new_file.close
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
    puts "Please provide username."
    @user = STDIN.gets.chomp

    shell %Q[curl -i -u #{@user} -d '{"scopes": ["repo"],"note": "gitFlone"}' https://api.github.com/authorizations]
    file.puts("machine github.com #{@user} #{@token}")
  end

  def shell (command)
    puts `#{command}`
  end

  def has_token?
    return !@token.nil? && @token.length==40
  end
end
