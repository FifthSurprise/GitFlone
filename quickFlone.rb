
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
end

@user = ARGV[0]
@gitdirectory = ARGV[1]
@branch = ARGV[2].nil? ? "Feature" : ARGV[2]

fork(@user,source,repoName)
clone(@user,repoName,@branch)
