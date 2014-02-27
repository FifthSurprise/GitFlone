GitFlone

Forks and Clones

Fork a repository on github and then clone the forked repository to the current directory.  Afterwards, create a new branch and open a pull request in the browser back to the forked repository.

Note, since no changes have been committed, the pull request can't be submitted. However once a commit has been pushed, the page can simply be refreshed. Optionally, the user can create a dummy file for the purpose of immediately opening a pull request.

Currently looks in ENV['HOME']/.netrc for a .netrc file with "machine github.com $username $TOKEN".  If the 40 character token isn't found, the application will ask for username/password and try to create a gitFlone OAuth token for you.  Likewise, a .netrc file will be generated if one does not exist in your home directory.

Parameters are: SSH Github Repo link, NewBranchName (Defaults to "Feature")