# Stephen Tudor's dotfiles

## dotfiles

The ZSH stuff here is mostly a fork of [holman's awesome
dotfiles](https://github.com/holman/dotfiles), but as I'm a fan of
[oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh), that bit is also
included as a submodule. Several of the scripts in `bin` were lifted from
[rtomayko](https://github.com/rtomayko/dotfiles) and various other sources
on the Internet over the years. The Vim configuration uses
[Vundle](https://github.com/gmarik/vundle) to manage its plugins.

If you're interested in the philosophy behind why projects like these are
awesome, you might want to [read holman's post on the
subject](http://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/).

## install

- `git clone git://github.com/smt/dotfiles ~/.dotfiles`
- `cd ~/.dotfiles`
- `rake install`

The install rake task will symlink the appropriate files in `.dotfiles` to your
home directory. Everything is configured and tweaked within `~/.dotfiles`,
though.

The main file you'll want to change right off the bat is `zsh/zshrc.symlink`,
which sets up a few paths that'll be different on your particular machine.

## topical

Everything's built around topic areas. If you're adding a new area to your
forked dotfiles — say, "Java" — you can simply add a `java` directory and put
files in there. Anything with an extension of `.zsh` will get automatically
included into your shell. Anything with an extension of `.symlink` will get
symlinked without extension into `$HOME` when you run `rake install`.

## what's inside

A lot of stuff. Seriously, a lot of stuff. Check them out in the file browser
above and see what components may mesh up with you. Fork it, remove what you
don't use, and build on what you do use.

## components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/\*.symlink**: Any files ending in `*.symlink` get symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `rake install`.
- **topic/\*.completion.sh**: Any files ending in `completion.sh` get loaded
  last so that they get loaded after we set up zsh autocomplete functions.

## bugs

To be clear, these are, first and foremost, **my** dotfiles that I use for my
own projects. From time to time, I may break something in my own setup and just
live with it for a while due to other priorities at the time. I try not to do
this, of course, but it can happen. Knowing this, you are free to use this
setup at your own risk. In general, it is fairly stable, and I definitely
welcome any suggestions for improvement!

## thanks

- [holman](http://github.com/holman)
- [rbates](http://github.com/ryanb)
- [rtomayko](http://github.com/rtomayko)
- [honza](http://github.com/honza)
- [vickaita](http://github.com/vickaita)
- [sontek](http://github.com/sontek)
- Tim Shortt
