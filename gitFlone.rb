def fork(user, source,repoName)
  shell %Q[curl -u '#{user}' https://api.github.com/repos/#{source}/#{repoName}/forks -d '{}']
end

def clone (user,repoName, branch="Feature")
  shell"git clone git@github.com:#{user}/#{repoName}.git"
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
  shell %Q[open https://github.com/#{@user}/#{@repoName}/compare/#{@branch}?expand=1]
end

def shell (command)
  puts `#{command}`
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
