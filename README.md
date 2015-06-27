[![Build Status](https://travis-ci.org/cyphactor/vim-open-alternate.svg?branch=master)](https://travis-ci.org/cyphactor/vim-open-alternate)

# open-alternate.vim

*Bringing alternate file opening to the forefront*

[![It in Action](http://andrewdeponte.com/vim-open-alternate/images/vim-open-alternate-intro-screenshot.png)](https://vimeo.com/66043605)

## What it provides?

This plugin provides a simple solution for opening alternate files
intelligently in [vim](http://www.vim.org). It does this by providing a
user-command called `OpenAlternate` which when executed will open the
alternate file to the currently opened file.

### Supported File Types

Currently, this plugin supports the following list of file types.

<table>
  <tr>
    <th>
      Current File
    </th>
    <th>
      Alternate File
    </th>
  </tr>
  <tr>
    <td>
      RSpec File
    </td>
    <td>
      Ruby Implementation file (includes logic for Ruby on Rails)
    </td>
  </tr>
  <tr>
    <td>
      Ruby Implementation File
    </td>
    <td>
      RSpec file (includes logic for Ruby on Rails)
    </td>
  </tr>
  <tr>
    <td>
      Cucumber Feature File
    </td>
    <td>
      Cucumber Step Definition file
    </td>
  </tr>
  <tr>
    <td>
      Cucumber Step Definition File
    </td>
    <td>
      Cucumber Feature file
    </td>
  </tr>
  <tr>
    <td>
      Rails Rake File
    </td>
    <td>
      Rails Rake Spec file
    </td>
  </tr>
</table>

## Installation

If you don't have a preferred installation method, I recommend installing
[pathogen.vim](https://github.com/tpope/vim-pathogen) and using it in
combination with [git
submodules](http://git-scm.com/book/en/Git-Tools-Submodules) as describe in
this [Vimcast - Synchronizing plugins with git submodules and
pathogen](http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/).

If your installation method is the above recommended one, it should be as
simple as running the following commands:

    cd ~/.vim/
    git submodule add git@github.com:cyphactor/vim-open-alternate.git bundle/vim-open-alternate
    git add .
    git commit -m "Added vim-open-alternate plugin to my setup."

If you are using another method, you are on your own. I have been told that
this plugin is compatible with [Vundle](http://github.com/gmarik/vundle)
but I have not tested it myself.

## Configuration

The recommended configuration for this plugin is to simply map a key combo to
run the `OpenAlternate` command for you. This can easily be done by adding the
following to your `~/.vimrc`.

    nnoremap <leader>. :OpenAlternate<cr>

In the above example I map my normal mode `<leader>.` key combo to execute the
`OpenAlternate` command, in turn opening the alternate file for editing.

You can of course map this command anyway you like, or even choose not to map
it and just execute the command as follows when you need it.

    :OpenAlternate<cr>

## Credits

I took the idea for my `<leader>.` binding and some logic for opening the
alternate file from Gary Bernhardt's vim setup. I also took bits and pieces of
file path conversions for alternate files from numerios friends `.vimrc`
files. Therefore, credit must go out to Gary Bernhardt for a reasonable
starting point as well as my numerous friends for sharing their alternate
file path conversions with me.

## License

Copyright (c) Andrew De Ponte. Distributed under the same terms as Vim itself.
See `:help license`.
