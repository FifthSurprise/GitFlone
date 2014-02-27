require_relative 'netrc'

class GitFlone
  def initialize
    @netrc = NetRC.new
  end

  def fork(source,repoName)
    if @netrc.has_token?
      shell %Q[curl -H 'Authorization: token #{@netrc.token}' https://api.github.com/repos/#{source}/#{repoName}/forks -d '{}']
    else
      shell %Q[curl -u '#{@netrc.user}' https://api.github.com/repos/#{source}/#{repoName}/forks -d '{}']
    end
    sleep(1) #ensure fork is there
  end

  def clone (repoName, branch="Feature")
    shell %Q[git clone git@github.com:#{@netrc.user}/#{repoName}.git]
    Dir.chdir("#{repoName}")
    shell %Q[git checkout -b #{branch}]
    shell %Q[git push origin #{branch}]
  end

  def pull (dummycommit="")
    if dummycommit.length > 0
      shell %Q[touch #{dummycommit}]
      shell %Q[git add #{dummycommit}]
      shell %Q[git commit -am "Initial #{@branch} commit"]
      shell %Q[git push origin #{@branch}]
    end
    shell %Q[open https://github.com/#{@netrc.user}/#{@repoName}/compare/#{@branch}?expand=1]
  end

  def shell (command)
    puts `#{command}`
  end

  def checkArg (pattern, string)
    values = string.scan(pattern).flatten.uniq
    raise ArgumentError, "Argument is invalid: #{string}" unless values.length==1
    return values.first
  end

  def run
    @user = ARGV[0]
    @gitdirectory = ARGV[1].split(":").last
    @branch = ARGV[2].nil? ? "Feature" : ARGV[2]
    @source = checkArg(%r[(?<=:)(\S+)(?=\/)], ARGV[1])
    @repoName = checkArg(%r[(?<=\/)(\S+)(?=\.)],ARGV[1])

    # fork(@source,@repoName)
    # clone(@repoName,@branch)

    # puts "Create an initial commit for pull request?"
    # puts "If so, provide a value for dummy pull request or leave blank to skip:"
    # dummy = STDIN.gets.chomp
    # pull(dummy)
  end
end
GitFlone.new.run
