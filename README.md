Dotfiles
========
These are my dotfiles. The configuration for my development environment.

Most of the goodies here are thanks to others who've also shared their dotfiles on Github.

## To Use
Clone this repo to your local machine, run the installer and then symlink the files to your home directory. Basically, just do the following:

```sh
git clone https://github.com/fab/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./installer && ./link-files
```

The ```link-files``` script will symlink the appropriate files in ```.dotfiles``` to your home directory. Make sure to tweak the files in ```~/.dotfiles``` for your own settings like Github credentials and remove whatever you don't need.
