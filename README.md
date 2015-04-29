# Dotfile config

## Install

```bash
bash <(curl -s https://d.pr/w8kA)
```

The shortened URL redirects to the [raw](https://raw.githubusercontent.com/smt/dotfiles/master/topics/bin/bootstrap.sh) version of this project's [bootstrap script](https://github.com/smt/dotfiles/blob/master/topics/bin/bootstrap.sh). Please review before running.

## Structure

1. Symlinks (under `locations`) indicate where the soon-to-be-created symlinks
   end up (relative to `~`).
2. The `topics` directory contains the actual dotfiles.
3. To create directories, use `<dir>.directory.symlink` links (under
   `locations`).
4. Try not to symlink directories -- instead, create them (with
   `<dir>.directory.symlink` links) and then symlink dotfiles into them.

## TODO

- Created directories should copy over permissions.
- The Rakefile should never overwrite locals.
