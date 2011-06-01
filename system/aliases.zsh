# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
if $(gls &>/dev/null)
then
  alias ls="gls -F --color"
  alias l="gls -lAh --color"
  alias ll="gls -l --color"
  alias la='gls -A --color'
fi

# Dirs
alias o="open ."
alias p="cd ~/Projects"
alias e="nocorrect mvim"

# Management
alias dots="cd $DOTS && mvim; -"
alias redot="cd $DOTS && gpp && rake install; -"

# Shell
#alias c='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
