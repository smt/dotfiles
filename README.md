# Dotfiles (powered by Ansible!)

## Install

To install just these dotfiles (or your custom fork):

```bash
git clone https://github.com/<USERNAME>/dotfiles ~/.dotfiles
cd ~/.dotfiles
rake
```

*Please Note:*

As is, the dotfiles assume the existence of certain languages and frameworks, such as Python, Ruby, Node.js, and other things that I myself use on a daily basis.

I am also a [fish](http://fishshell.com/) user, so if you're not, lots of things won't work or make sense to you. All that being said, you should probably consider switching to fish. The dream of the '90s is still alive.

### Dotfile Structure

1. Symlinks (under `locations`) indicate where the soon-to-be-created symlinks end up (relative to `~`).
2. The `topics` directory contains the actual dotfiles.
3. To create directories, use `<dir>.directory.symlink` links (under `locations`).
4. Try not to symlink directories -- instead, create them (with `<dir>.directory.symlink` links) and then symlink dotfiles into them (this is kind of a pain in the butt).

## Full Environment Install

![flashing red emergency vehicle lights](http://static.sites.yp.com/var/m_6/63/63a/10981405/150888-lightbaranimated.gif)

Actually, better not to try this unless you're actually me, but here goes anyway:

```bash
bash <(curl -sL https://d.pr/w8kA)
```

The shortened URL redirects to the [raw](https://raw.githubusercontent.com/smt/dotfiles/master/topics/bin/bootstrap.sh) version of this project's [bootstrap script](https://github.com/smt/dotfiles/blob/master/topics/bin/bootstrap.sh). Please review before running.

### How It Works

The bootstrap script installs a few minumum dependencies, including Xcode and Homebrew. It also optionally generates a BitBucket deploy key so that the script can access my private repo.

Yeah, there's a private repo involved, sorry. It primarily consists of an Ansible playbook set up similar to the description in [this article](http://il.luminat.us/blog/2014/04/19/how-i-fully-automated-os-x-with-ansible/). The private playbook includes my two public Ansible roles, [base_osx](https://github.com/smt/ansible-base-osx/) and [dotfiles](https://github.com/smt/ansible-dotfiles/), as Git submodules.

Anyway, Ansible `git clone`s and `brew install`s a bunch of stuff, including this very repo, and then runs the [Rakefile](https://github.com/smt/dotfiles/blob/master/Rakefile) to link up all the dotfiles into the locations where they go.

## About the dotfiles, Ansible, etc.

My dotfiles have a long, pox-ridden history of nukings. Lots of them. Let's just call it... "aggressive refactoring."

And yet here they are, reborn as ever. I'm not going to claim that this is their final incarnation—I know better than that, now. But I will say that this is the best setup I've had yet.

### A man, a plan, his dotfiles, and coffee

This repo also represents my first fully-committed attempt at automating a hefty chunk of my environment and configuration on a brand-new machine. A Mac, specifically. I don't often find myself on the receiving end of a spiffy new Mac, but when I'm about to start a new job (as I am, in just a few weeks), I get a bit itchy when I think about all that time I'll be wasting setting up my software.

So naturally, I decided to waste at least an order of magnitude more time preparing what I hoped would be the holy grail of automated setups. It falls far short of that standard, of course, but it's a start, and I think I'll be satisfied with the jump-start I get in terms of near-immediate productivity.

Chances are, I'll be able to take these learnings and abstract them into a tool my future employer can use for onboarding new developers.

### In which I finally mention Ansible for a sentence or three

That's where [Ansible](http://www.ansible.com) comes in. I had no desire to use Puppet or Chef for this (I'd already given [Boxen](https://github.com/boxen/boxen) a more than fair attempt), and as I've been using Ansible for various automation tasks in my current day job, it seemed like a logical choice. It's really an amazing tool, and in this project I've barely even scratched the surface of what it is capable of.

## Credit

I'm been inspired the great work of these people. My sincere thanks to:

- **James Tomasino**, for his continuous tinkering on his awesome [dotfiles](https://github.com/jamestomasino/dotfiles) and [binfiles](https://github.com/jamestomasino/bin).
- **Daniel Jaouen**, for re-kindling my **Ansible + OS X** dream with [this blog post](http://il.luminat.us/blog/2014/04/19/how-i-fully-automated-os-x-with-ansible/). My playbooks are still just forks of his.
- **Jeff Geerling**, who not only has a very interesting [Mac dev playbook](https://github.com/geerlingguy/mac-dev-playbook) of his own, but also has a very thorough resource on how to get a [Mac OS X Virtualbox VM](https://github.com/geerlingguy/mac-osx-virtualbox-vm) up and running (testing this stuff out on a fresh snapshot is so critical!).
- **Mathias Bynens**, for his painstakingly curated collection of [OS X preferences](https://github.com/mathiasbynens/dotfiles/blob/master/.osx).
- **Zach Holman**, for the [initial inspiration](https://github.com/holman/dotfiles/) to start my own dotfiles repo.
- **Ryan Tomayko**, for various useful [utility scripts](https://github.com/rtomayko/dotfiles/tree/rtomayko/bin).

## TODO

- Created directories should copy over permissions.
- The Rakefile should never overwrite locals.
