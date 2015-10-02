# flowhighlight

This is a Vim plugin that highlights if-else-endif structures
in different colors based on their 'level' in the program flow. 
As of October 2015 only works with Fortran.
VERY EARLY DEVELOPMENT VERSION!

![Screenshot](http://i.imgur.com/EEkyytY.jpg)

## Installation

Use your plugin manager of choice.

- [Pathogen](https://github.com/tpope/vim-pathogen)
  - `git clone https://github.com/fpnick/flowhighlight ~/.vim/bundle/flowhighlight`
- [Vundle](https://github.com/gmarik/vundle)
  - Add `Bundle 'https://github.com/fpnick/flowhighlight'` to .vimrc
  - Run `:BundleInstall`
- [NeoBundle](https://github.com/Shougo/neobundle.vim)
  - Add `NeoBundle 'https://github.com/fpnick/flowhighlight'` to .vimrc
  - Run `:NeoBundleInstall`
- [vim-plug](https://github.com/junegunn/vim-plug)
  - Add `Plug 'https://github.com/fpnick/flowhighlight'` to .vimrc
  - Run `:PlugInstall`

## Changelog
- 0.1.1
  - Added refresh function

## Todo

1. Extend to other languages.
