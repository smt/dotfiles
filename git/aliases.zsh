# The rest of my fun git aliases
alias gar="git-addremove"
alias gl='git pull --prune'
alias gam="git commit --amend"
alias gd="git diff"
alias gpp="git-up"
alias gr="git rebase"
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias gs="git status -sb" # upgrade your git if -sb breaks for you. it's fun.

# Included for legacy purposes
alias gci="git commit"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gsci="git svn dcommit"
alias gsf="git svn fetch"
alias gsup="git svn rebase"
