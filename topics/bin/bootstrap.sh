#!/bin/bash

set -e
set -x

SRC_DIRECTORY="$HOME/src"
ANSIBLE_DIRECTORY="$SRC_DIRECTORY/ansible"
ANSIBLE_CONFIGURATION_DIRECTORY="$HOME/.ansible.d"

if [[ -x /usr/bin/sw_vers ]]; then
    OSX_VERSION=$(sw_vers | grep 'ProductVersion:' | awk '{print $2}' | cut -d . -f 1,2 -)
else
    echo "Error  | OS Check  | osx"
    return 1
fi

# Download and install Command Line Tools
xcode-select -p 1>/dev/null
if [ $? -ne 0 ]; then
    echo "Info   | Install   | xcode"
    xcode-select --install
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
    brew install ansible
fi

# Make the code directory
mkdir -p $SRC_DIRECTORY

# Clone down ansible
if [[ ! -d $ANSIBLE_DIRECTORY ]]; then
    git clone -b devel https://github.com/ansible/ansible.git $ANSIBLE_DIRECTORY
fi

# Use the forked Ansible
source $ANSIBLE_DIRECTORY/hacking/env-setup > /dev/null

# Clone down the Ansible repo
if [[ ! -d $ANSIBLE_CONFIGURATION_DIRECTORY ]]; then
    git clone git@bitbucket.org:studor/ansible-base-box.git $ANSIBLE_CONFIGURATION_DIRECTORY
    (cd $ANSIBLE_CONFIGURATION_DIRECTORY && git submodule init && git submodule update)
fi

# Provision the box
ansible-playbook -v --ask-sudo-pass -i $ANSIBLE_CONFIGURATION_DIRECTORY/inventories/osx $ANSIBLE_CONFIGURATION_DIRECTORY/site.yml --connection=local

# Link the casks.
~/.bin/link-casks
