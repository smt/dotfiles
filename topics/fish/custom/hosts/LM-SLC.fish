# set -gx PATH $HOME/src/ansible/bin $PATH

# set -gx ANSIBLE_LIBRARY $HOME/src/ansible/library

# set -gx MANPATH $HOME/src/ansible/docs/man $MANPATH

set -gx BOOT2DOCKER_IP 192.168.59.103
set -gx VAGRANT_IP     192.168.58.103

#set -gx DOCKER_HOST tcp://$BOOT2DOCKER_IP:2376
set -gx DOCKER_HOST tcp://$VAGRANT_IP:2375

set -gx DOCKER_CERT_PATH $HOME/.boot2docker/certs/boot2docker-vm

#set -gx DOCKER_TLS_VERIFY 1
set -e DOCKER_TLS_VERIFY
