export DAWN_PATH="$HOME/Dropbox/Workbench/empathylab/dawn"
export STB_IP_VGW="172.24.200.147"
export STB_CONF="$DAWN_PATH/.user.json"
export STB_KEY="$DAWN_PATH/stb-scripts/keys/stb_rsa"

function createStbShell() {
    local stbip=`node -e "console.log(JSON.parse(require('fs').readFileSync('$STB_CONF')).stb[0].ip)"`
    local stbuser=`node -e "console.log(JSON.parse(require('fs').readFileSync('$STB_CONF')).stb[0].username)"`
    chmod 0600 $STB_KEY
    ssh -i $STB_KEY $stbuser@$stbip
}

function createStbTunnel() {
    local stbip=`node -e "console.log(JSON.parse(require('fs').readFileSync('$STB_CONF')).stb[0].ip)"`
    local stbuser=`node -e "console.log(JSON.parse(require('fs').readFileSync('$STB_CONF')).stb[0].username)"`
    chmod 0600 $STB_KEY
    ssh -i $STB_KEY -f $stbuser@$stbip -L 8081:$stbip:8081 -N
}

function createStbTelnet() {
    local stbip=`node -e "console.log(JSON.parse(require('fs').readFileSync('$STB_CONF')).stb[0].ip)"`
    telnet $stbip
}

function tailStbBrowserLogs() {
    local stbip=`node -e "console.log(JSON.parse(require('fs').readFileSync('$STB_CONF')).stb[0].ip)"`
    local stbuser=`node -e "console.log(JSON.parse(require('fs').readFileSync('$STB_CONF')).stb[0].username)"`
    chmod 0600 $STB_KEY
    multitail -l 'ssh -i $STB_KEY $stbuser@$stbip tail -f /opt/logs/mwb.log' \
              -l 'ssh -i $STB_KEY $stbuser@$stbip tail -f /opt/logs/ocapri_log.txt'
}

alias stbtunnel=createStbTunnel
alias stbshell=createStbShell
alias stbtelnet=createStbTelnet
# alias stbtail=tailStbBrowserLogs
alias stbtail="multitail -l 'ssh -i $STB_KEY root@$STB_IP_VGW tail -f /opt/logs/mwb.log' -l 'ssh -i $STB_KEY root@$STB_IP_VGW tail -f /opt/logs/ocapri_log.txt'"

function dawnTailStb() {
    ssh -i $STB_KEY -t root@$STB_IP_VGW 'touch /opt/logs/mwb.log && tail -f /opt/logs/mwb.log' | \
        # colout "^.*$" Rainbow normal
        colout "^\".*Z  DEBUG  .*$" none normal | \
        colout "^\".*controller\.do.*$" cyan normal | \
        colout "^\"DAWN.*Z - INFO:.*$" blue normal | \
        colout "^\"DAWN.*Z - DEBUG:.*$" magenta normal | \
        colout "^\"DAWN.*Z - WARN:.*$" yellow normal | \
        colout "^\"DAWN.*Z - ERROR:.*$" red normal | \
        colout "^\"DAWN.*Z.*$" white normal | \
        colout "^\".*STOPWATCH.*$" green normal
}
alias dawn-tail-stb=dawnTailStb

alias touchdusts="find $DAWN_PATH/src/templates/dusts/ -type f | xargs touch"

alias dawn-ssh="ssh -o StrictHostKeyChecking=no -i $STB_KEY root@$STB_IP_VGW"
