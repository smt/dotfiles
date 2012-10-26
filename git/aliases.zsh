alias g="git"

# The rest of my fun git aliases
alias gaa="git add -A"
alias gl='git pull --prune'
alias gam="git commit --amend"
alias gd="git diff"
alias gpp="git-up && git push"
alias gr="git rebase"
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias gs="git status -sb" # upgrade your git if -sb breaks for you. it's fun.
alias gf="git flow"
alias gffs="gf feature start"
alias gfff="gf feature finish"
alias gfrs="gf release start"
alias gfrf="gf release finish"

# Included for legacy purposes
alias gci="git commit -v"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --"
# alias gsci="git svn dcommit"
# alias gsf="git svn fetch"
# alias gsup="git svn rebase"
