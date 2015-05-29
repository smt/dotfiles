# setup ------------------------------------------------------------------- {{{
set fish_path $HOME/.oh-my-fish
set fish_theme edan
set fish_plugins export extract localhost osx php proxy pyenv rbenv replace theme
# /setup ------------------------------------------------------------------ }}}

# PATH -------------------------------------------------------------------- {{{
set BASE_PATH /bin
set BASE_PATH /sbin $BASE_PATH
set BASE_PATH /usr/bin $BASE_PATH
set BASE_PATH /usr/sbin $BASE_PATH
set BASE_PATH /usr/local/bin $BASE_PATH
set BASE_PATH /usr/local/sbin $BASE_PATH

set BREW_PREFIX (brew --prefix)

switch (uname)
    case Darwin
        set -x GOPATH /usr/local/var/go
        set LOCAL_PATH /usr/texbin
        # set LOCAL_PATH /usr/X11/bin $LOCAL_PATH
        set LOCAL_PATH /usr/local/opt/ruby/bin $LOCAL_PATH
        set LOCAL_PATH /usr/local/deployd/bin $LOCAL_PATH
        set LOCAL_PATH /usr/local/share/npm/bin $LOCAL_PATH
        set LOCAL_PATH $BREW_PREFIX/Cellar/go/1.4.2/libexec/bin $LOCAL_PATH
        set LOCAL_PATH $GOPATH/bin $LOCAL_PATH
        set LOCAL_PATH /Library/Java/JavaVirtualMachines/jdk1.8.0_40.jdk/Contents/Home/bin $LOCAL_PATH
        set LOCAL_PATH $HOME/.fzf/bin $LOCAL_PATH
        set LOCAL_PATH $HOME/.node/bin $LOCAL_PATH
        set LOCAL_PATH $HOME/.cabal/bin $LOCAL_PATH
        set LOCAL_PATH $HOME/.bin $LOCAL_PATH
        set -x PATH $LOCAL_PATH $BASE_PATH
    case Linux
        set -x GOPATH /var/go
        set LOCAL_PATH $GOPATH/bin
        set LOCAL_PATH $HOME/.fzf/bin $LOCAL_PATH
        set LOCAL_PATH $HOME/.cabal/bin $LOCAL_PATH
        set LOCAL_PATH $HOME/.bin $LOCALPATH
        set -x PATH $LOCAL_PATH $BASE_PATH
end
# /PATH ------------------------------------------------------------------- }}}

# Path to your custom folder (default path is $FISH/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

# Load oh-my-fish configuration.
source $fish_path/oh-my-fish.fish

# Load nvm-wrapper
source $HOME/.nvm-wrapper/nvm.fish

# OS-specific configuration ----------------------------------------------- {{{
switch (uname)
    case Darwin
        set -x MAIL $HOME/Mail
        # set -x PKG_CONFIG_PATH /opt/X11/lib/pkgconfig
        set -x SHELL /usr/local/bin/fish
        set -x JAVA_HOME /Library/Java/JavaVirtualMachines/jdk1.8.0_40.jdk/Contents/Home/jre
        set -x PAGER less
        # set -x CA_CERTIFICATE /usr/local/opt/curl-ca-bundle/share/ca-bundle.crt

        function update
            curl https://raw.githubusercontent.com/smt/dotfiles/master/topics/bin/bootstrap.sh | bash
        end
        function systemupdate
            sudo softwareupdate -i -a
            brew update
            brew upgrade
        end
        function cb
            tr -d '\n' | pbcopy
        end
        function cl
            fc -e - | pbcopy
        end
        function cpwd
            pwd | cb
        end

        # aws --------------------------------------------------------------------- {{{
        # /aws -------------------------------------------------------------------- }}}
    case Linux
        set -x SHELL /usr/bin/fish
        function pbcopy
            xclip -selection clipboard $argv
        end
        function pbpaste
            xclip -selection clipboard -o $argv
        end
        function open
            xdg-open $argv
        end
        # eval "$(ssh-agent)"
end
# /OS-specific configuration ---------------------------------------------- }}}

# Global Options and Aliases ---------------------------------------------- {{{
set -x EDITOR vim
set -x TERM screen-256color-bce
set -x PYENV_ROOT $HOME/.pyenv
set -x RBENV_ROOT $HOME/.rbenv
set -x ANSIBLE_NOCOWS 1
set -x LSCOLORS gxfxbEaEBxxEhEhBaDaCaD
set -x LS_COLORS 'di=36;40:ln=35;40:so=31;1;44:pi=0;1;44:ex=1;31;40:bd=0;1;44:cd=37;1;44:su=37;1;41:sg=0;1;43:tw=0;1;42:ow=0;1;43:'

function reload
    source $HOME/.config/fish/config.fish
end
function l
    gls -oA --time-style="long-iso" --color="auto" $argv
end
function ls
    gls --color="auto" $argv
end
function lsd
    gls -oA --time-style="long-iso" --color="auto" | grep "^d" $argv
end
function lsort
    echo "========== Newest =========="
    gls -At1 --color="auto"
    echo "========== Oldest =========="
end
function e
    eval $EDITOR $argv
end
function imgsz
    sips -g pixelWidth -g pixelHeight
end
function mtr
    command sudo mtr -t $argv
end
function mute
    command vol 0 $argv
end
function n
    command newsbeuter $argv
end
function serve_this
    command python -m SimpleHTTPServer 8100 $argv
end
function ...
    cd ../..
end
# /Global Options and Aliases --------------------------------------------- }}}

# ag ---------------------------------------------------------------------- {{{
function agjs
    command ag -G '.*\.js$' $argv
end
function agpy
    command ag -G '.*\.py$' $argv
end
function aghtml
    command ag -G '.*\.html$' $argv
end
function agyml
    command ag -G '.*\.yml$' $argv
end
function agrb
    command ag -G '.*\.rb$' $argv
end
# /ag --------------------------------------------------------------------- }}}

# ansible ----------------------------------------------------------------- {{{
function a
    command ansible $argv
end
function ap
    command ansible-playbook $argv
end
function api
    command ansible-playbook -i $argv
end
function apik
    command ansible-playbook --ask-sudo-pass -i $argv
end
function apvi
    command ansible-playbook -vvvv -i $argv
end
function apvik
    command ansible-playbook -vvvv --ask-sudo-pass -i $argv
end
function apio
    command ansible-playbook -i ~/.ansible.d/inventories/osx $argv
end
function apios
    command ansible-playbook -i ~/.ansible.d/inventories/osx ~/.ansible.d/site.yml $argv
end
function av
    command ansible-vault $argv
end
# /ansible ---------------------------------------------------------------- }}}

# cloc -------------------------------------------------------------------- {{{
function cloc
    command cloc --read-lang-def=$HOME/.clocrc $argv
end
# /cloc ------------------------------------------------------------------- }}}

# docker ------------------------------------------------------------------ {{{
function dr
    command docker $argv
end
function dri
    command docker images $argv
end
function drpl
    command docker pull $argv
end
function drps
    command docker ps $argv
end
function drpu
    command docker push $argv
end
function drr
    command docker run $argv
end
function drs
    command docker search $argv
end
# /docker ----------------------------------------------------------------- }}}

# git --------------------------------------------------------------------- {{{
function g
    command git $argv
end
function ga
    command git add $argv
end
function gaa
    command git add -A $argv
end
function gam
    command git commit --amend $argv
end
function gap
    command git add --p $argv
end
function gci
    command git commit -m $argv
end
function glog
    command git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit -- $argv
end
function gp
    command git pull $argv
end
function gpu
    command git push $argv
end
function gst
    command git status $argv
end
function gss
    command git status -s $argv
end
# /git -------------------------------------------------------------------- }}}

# go ---------------------------------------------------------------------- {{{
# /go --------------------------------------------------------------------- }}}

# hg ---------------------------------------------------------------------- {{{
function h
    command hg $argv
end
function hc
    command hg commit -m $argv
end
function hm
    command hg commit -m 'merge.' $argv
end
function hp
    command hg $argv
end
function hpu
    command hg $argv
end
function hqci
    command hg qci $argv
end
function hqf
    command hg qf $argv
end
function hqgl
    command hg qgl $argv
end
function hqi
    command hg qi $argv
end
function hqlog
    command hg gqlog $argv
end
function hqn
    command hg qn $argv
end
function hqpo
    command hg qpo $argv
end
function hqpoa
    command hg qpoa $argv
end
function hqpua
    command hg qpua $argv
end
function hqq
    command hg qq $argv
end
function hqr
    command hg qr $argv
end
function hqrm
    command hg qrm $argv
end
function hqst
    command hg qst $argv
end
function hup
    command hg up $argv
end
# /hg --------------------------------------------------------------------- }}}

# javascript/node.js ------------------------------------------------------ {{{
# . ~/.nvm/nvm.sh
function gu
    command grunt $argv
end
# /javascript/node.js ----------------------------------------------------- }}}

# network ----------------------------------------------------------------- {{{
function flushdns
    dscacheutil -flushcache
    sudo killall -HUP mDNSResponder
end
function extip
    command dig +short myip.opendns.com @resolver1.opendns.com
end
function ip
    command ipconfig getifaddr $argv
end
function ips
    command ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/; print $argv'
end
function sniff
    command sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'
end
function httpdump
    command sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E "Host\: .*|GET \/.*"
end
# /network ---------------------------------------------------------------- }}}

# # python/django ----------------------------------------------------------- {{{
# set -x PYTHONSTARTUP "$HOME/.pythonrc.py"
# # set -x PYTHONPATH "$HOME/src/ansible/lib
##  set -x ANSIBLE_LIBRARY "$HOME/src/ansible/library

# set -x VIRTUALFISH_COMPAT_ALIASES 1
# source $HOME/.virtualfish/virtual.fish
# source $HOME/.virtualfish/auto_activation.fish
# source $HOME/.virtualfish/global_requirements.fish
# set -x VIRTUAL_ENV_DISABLE_PROMPT 0

# function daspt
#     command django-admin.py startproject --template=https://github.com/danieljaouen/django-twoscoops-project/archive/develop.zip --extension=py,rst,html $argv
# end
# function fd
#     command fab dev $argv
# end
# function pm
#     command python manage.py $argv
# end
# function pmm
#     command python manage.py migrate $argv
# end
# function pmr
#     command python manage.py runserver $argv
# end
# function pmrp
#     command python manage.py runserver_plus $argv
# end
# function pmrpg
#     command python manage.py runserver_plus --adminmedia=`pwd`/media/admin $argv
# end
# function pms
#     command python manage.py shell $argv
# end
# function pmsdb
#     command python manage.py syncdb $argv
# end
# function pmsi
#     command python manage.py schemamigration --initial $argv
# end
# function pmsm
#     command python manage.py schemamigration --auto $argv
# end
# function pmsp
#     command python manage.py shell_plus $argv
# end
# function pyr
#     command pyenv rehash $argv
# end
# # /python/django ---------------------------------------------------------- }}}

# ruby/rails -------------------------------------------------------------- {{{
# function b
#     command bundle $argv
# end
function be
    command bundle exec $argv
end
function bec
    command bundle exec cucumber $argv
end
function beg
    command bundle exec rails generate $argv
end
function ber
    command bundle exec rake $argv
end
function bers
    command bundle exec rspec $argv
end
function bi
    command bundle install $argv
end
function bu
    command bundle update $argv
end
function rn
    command rails new $argv
end
function rt
    command rake ctags $argv
end
function rr
    command rbenv rehash $argv
end
function bug
    command bundle gem $1 --bin --test $argv
end
# /ruby/rails ------------------------------------------------------------- }}}

# snippets ---------------------------------------------------------------- {{{
function esnip
    e ~/.sniprc
end
function emulti
    ls ~/.multisnip | fzf -e -i > $TMPDIR/fzf.result;
    and e ~/.multisnip/(cat $TMPDIR/fzf.result)
end
function multisnip
    e ~/.multisnip/$argv
end
# /snippets --------------------------------------------------------------- }}}

# vagrant ----------------------------------------------------------------- {{{
function v
    command vagrant $argv
end
function vp
    command vagrant provision $argv
end
function vs
    command vagrant suspend $argv
end
function vup
    command vagrant up $argv
end
function vupa
    command vagrant up --provider=aws $argv
end
# /vagrant ---------------------------------------------------------------- }}}

# tmux -------------------------------------------------------------------- {{{
function t
    command tmux $argv
end
function tms
    command tmux -S /tmp/shareds new -s shared $argv
end
function tma
    command tmux -S /tmp/shareds attach -t shared $argv
end
# /tmux ------------------------------------------------------------------- }}}

# Local Configuration ----------------------------------------------------- {{{
if test -s $HOME/.fishrc.local
    source $HOME/.fishrc.local
end
# /Local Configuration ---------------------------------------------------- }}}
