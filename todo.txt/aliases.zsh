# todo.sh: https://github.com/ginatrapani/todo.txt-cli
function t() { 
  if [ $# -eq 0 ]; then
    $DOTS/todo.txt/cli/todo.sh ls
  else
    $DOTS/todo.txt/cli/todo.sh $*
  fi
}

alias n="t ls +next"
