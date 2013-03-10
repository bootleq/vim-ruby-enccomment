ruby_enccomment.vim
===================

Insert `# encoding: utf-8` magic commet for Ruby 1.9 and above.


Usage
=====

- Call `do` function in Vim:

    :call ruby_enccomment#do()

- Batch processing from zsh:

    vim -p $(echo `find app/models -type f -print0`) -c 'tabdo call ruby_enccomment#do(0,1)'


Requirements
============

Proper 'filetype' and 'syntax' settings.

If you see ruby comments with correct color, there should be no problems.
Otherwise, add something like `:syntax on` to .vimrc.


Similar Projects
================

- [matic_encoding][] gem by @m-ryan
- [auto-encoding-for-ruby][] for Sublime Text 2, by @elomarns,


[magic_encoding]: https://github.com/m-ryan/magic_encoding
[auto-encoding-for-ruby]: https://github.com/elomarns/auto-encoding-for-ruby
