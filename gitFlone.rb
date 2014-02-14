def fork(user, source,repoName)
  command = "curl -u '#{user}' https://api.github.com/repos/#{source}/#{repoName}/forks -d '{}'"
  puts `#{command}`
end

def clone (user,repoName, branch="Feature")
  command = "git clone git@github.com:#{user}/#{repoName}.git"
  puts`#{command}`
  Dir.chdir("#{repoName}")
  command = "git checkout -b #{branch}"
  puts`#{command}`
  command = "git push origin #{branch}"
  puts`#{command}`
end

def pull (dummycommit="")
  commands = []
  if dummycommit.length > 0
    commands = ["touch #{dummycommit}"]
    commands.push("git add #{dummycommit}")
    commands.push(%Q[git commit -am "Initial #{@branch} commit"])
    commands.push(%Q[git push origin #{@branch}])
  end
  commands.push %Q[open https://github.com/#{@user}/#{@repoName}/compare/#{@branch}?expand=1]
  commands.each {|command|puts `#{command}`}
end

@user = ARGV[0]
@gitdirectory = ARGV[1].split(":").last
@branch = ARGV[2].nil? ? "Feature" : ARGV[2]
@source = @gitdirectory.split("/").first
@repoName = (@gitdirectory.split("/").last).split(".").first

fork(@user,@source,@repoName)
clone(@user,@repoName,@branch)

puts "Create an initial commit for pull request?"
puts "Provide a value for dummy pull request or leave blank to skip:"
dummy = STDIN.gets
pull(dummy)
