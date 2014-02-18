GitFlone

Forks and Clones

Fork a repository on github and then clone the forked repository to the current directory.  Afterwards, create a new branch and open a pull request in the browser back to the forked repository.

Note, since no changes have been committed, the pull request can't be submitted. However once a commit has been pushed, the page can simply be refreshed.

Currently looks in ENV['HOME']/.netrc for a .netrc file with "machine github.com login $TOKEN".  If the 40 character token isn't found, the user is prompted for a password when forking.

Parameters are: Username, SSH Github Repo link, NewBranchName (Defaults to "Feature")