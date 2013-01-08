export DAWN_STB_IP="172.24.20.123"

alias dawn-ssh-tunnel="ssh -f root@$DAWN_STB_IP -L 8081:$DAWN_STB_IP:8081 -N"
