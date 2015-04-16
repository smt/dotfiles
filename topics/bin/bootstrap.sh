#!/bin/bash

#set -e
set -x

SRC_DIRECTORY="$HOME/src"
SSH_DIRECTORY="$HOME/.ssh"
ANSIBLE_DIRECTORY="$SRC_DIRECTORY/ansible"
ANSIBLE_CONFIGURATION_DIRECTORY="$HOME/.ansible.d"

if [[ -x /usr/bin/sw_vers ]]; then
    OSX_VERSION=$(sw_vers | grep 'ProductVersion:' | awk '{print $2}' | cut -d . -f 1,2 -)
else
    echo "Error  | OS Check  | osx"
    return 1
fi

# Download and install Command Line Tools
xcode-select -p > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Info   | Install   | xcode"
    xcode-select --install
    read -rsp $'Press any key to continue...\n' -n1 key
fi

# Download and install Homebrew
if [[ ! -x /usr/local/bin/brew ]]; then
    echo "Info   | Install   | homebrew"
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
fi

# Modify the PATH
export PATH=/usr/local/bin:$PATH

# Download and install fish
if [[ ! -x /usr/local/bin/fish ]]; then
    echo "Info   | Install   | fish"
    brew install fish
fi

# Download and install git
if [[ ! -x /usr/local/bin/git ]]; then
    echo "Info   | Install   | git"
    brew install git
fi

# Download and install python
if [[ ! -x /usr/local/bin/python ]]; then
    echo "Info   | Install   | python"
    brew install python --framework --with-brewed-openssl
fi

# Download and install vim
if [[ ! -x /usr/local/bin/vim ]]; then
    echo "Info   | Install   | vim"
    brew install vim --override-system-vi --with-lua --with-tcl
fi

# Download and install Ansible
if [[ ! -x /usr/local/bin/ansible ]]; then
    echo "Info   | Install   | ansible"
    brew install ansible
fi

# Make the code directory
mkdir -p $SRC_DIRECTORY

# Clone down ansible
if [[ ! -d $ANSIBLE_DIRECTORY ]]; then
    git clone -b devel --recursive https://github.com/ansible/ansible.git $ANSIBLE_DIRECTORY
fi

# Use the forked Ansible
source $ANSIBLE_DIRECTORY/hacking/env-setup > /dev/null

# Create a BitBucket deploy key?
echo "Would you like to generate a read-only deploy key to access the private base-box repo?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) echo "Info   | Configure   | deploykey"
              mkdir -p $SSH_DIRECTORY
              ssh-keygen -f $SSH_DIRECTORY/ansible_base_box_deploykey -t rsa -N ''
              cat $SSH_DIRECTORY/ansible_base_box_deploykey.pub | pbcopy
              echo "In the browser, paste the public key (now copied to your clipboard) as a new deploy key in the BitBucket repo."
              sleep 3
              open https://bitbucket.org/studor/ansible-base-box/admin/deploy-keys
              read -rsp $'Press any key to continue...\n' -n1 key
              echo "Creating a SSH config entry using 'ansible_base_box_deploykey' (you may want to delete this later)."
              cat <<EOF >> $SSH_DIRECTORY/config
Host bitbucket.org
Hostname bitbucket.org
User git
IdentityFile %d/.ssh/ansible_base_box_deploykey
EOF
              break;;
        No ) break;;
    esac
done

# Clone down the Ansible repo
if [[ ! -d $ANSIBLE_CONFIGURATION_DIRECTORY ]]; then
    echo "Info   | Configure   | ansible.d"
    git clone git@bitbucket.org:studor/ansible-base-box.git $ANSIBLE_CONFIGURATION_DIRECTORY
    (cd $ANSIBLE_CONFIGURATION_DIRECTORY && git submodule init && git submodule update)
fi

# Provision the box
echo "Info   | Configure   | ansible-playbook"
ansible-playbook -e "username=$(whoami)" -v --ask-sudo-pass -i $ANSIBLE_CONFIGURATION_DIRECTORY/inventories/osx $ANSIBLE_CONFIGURATION_DIRECTORY/site.yml --connection=local

# Link the casks.
echo "Info   | Configure   | link-casks"
~/.bin/link-casks
