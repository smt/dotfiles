export STB_CONF='/Users/studor/Dropbox/Workbench/empathylab/dawn/.user.json'
export STB_KEY='/Users/studor/Dropbox/Workbench/empathylab/dawn/stb-scripts/keys/stb_rsa'

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
alias stbtail="multitail -l 'ssh -i $STB_KEY root@172.24.200.146 tail -f /opt/logs/mwb.log' -l 'ssh -i $STB_KEY root@172.24.200.146 tail -f /opt/logs/ocapri_log.txt'"
