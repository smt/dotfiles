# Dotfiles (powered by stow)

## Dependencies

Please ensure you've installed `stow` on your system.

```bash
brew install stow
```

```bash
sudo pacman -S stow
```

```bash
sudo apt-get install stow
```

## Install

To install just these dotfiles (or your custom fork):

```bash
git clone https://github.com/<USERNAME>/dotfiles ~/.dotfiles
cd ~/.dotfiles
install_osx  # or install_linux
```

## Credit

I'm been inspired the great work of these people. My sincere thanks to:

- **Eric Schull**, for pointing out the simplicity of [using stow to manage dotfiles](http://spin.atomicobject.com/2014/12/26/manage-dotfiles-gnu-stow/).
- **James Tomasino**, for his continuous tinkering on his awesome [dotfiles](https://github.com/jamestomasino/dotfiles) and [binfiles](https://github.com/jamestomasino/bin).
- **Daniel Jaouen**, for re-kindling my **Ansible + OS X** dream with [this blog post](http://il.luminat.us/blog/2014/04/19/how-i-fully-automated-os-x-with-ansible/). My playbooks are still just forks of his.
- **Jeff Geerling**, who not only has a very interesting [Mac dev playbook](https://github.com/geerlingguy/mac-dev-playbook) of his own, but also has a very thorough resource on how to get a [Mac OS X Virtualbox VM](https://github.com/geerlingguy/mac-osx-virtualbox-vm) up and running (testing this stuff out on a fresh snapshot is so critical!).
- **Mathias Bynens**, for his painstakingly curated collection of [OS X preferences](https://github.com/mathiasbynens/dotfiles/blob/master/.osx).
- **Zach Holman**, for the [initial inspiration](https://github.com/holman/dotfiles/) to start my own dotfiles repo.
- **Ryan Tomayko**, for various useful [utility scripts](https://github.com/rtomayko/dotfiles/tree/rtomayko/bin).

## TODO

- [ ] Add more stuff, be smarter, etc.
