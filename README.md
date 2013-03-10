ruby_enccomment.vim
===================

Insert `# encoding: utf-8` magic commet, for Ruby 1.9 and above.

You can set which __"filetypes"__ should be concerned,
what __"character pattern"__ should be counted as the encoding (thus really need magic comments),
and what __"comment format"__ should be used.


Usage
=====

`:call ruby_enccomment#do()`, which takes 2 optional arguments:

  1. `verbose` - if `0`, no message will be echoed when no line has been inserted.
  2. `inplace` - if `1`, save the file in place after insertion.

---

For batch files processing, below is an example for zsh:

    vim -p $(echo `find app/models -type f -print0`) -c 'tabdo call ruby_enccomment#do(0,1)'


Requirements
============

Proper _'filetype'_ and _'syntax'_ settings.

If you see ruby comments with correct color, there should be no problems.
Otherwise, add something like `:syntax on` to .vimrc.


Similar Projects
================

- [magic_encoding][] gem by @m-ryan
- [auto-encoding-for-ruby][] for Sublime Text 2, by @elomarns,


[magic_encoding]: https://github.com/m-ryan/magic_encoding
[auto-encoding-for-ruby]: https://github.com/elomarns/auto-encoding-for-ruby
