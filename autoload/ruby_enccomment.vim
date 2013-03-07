" Constants: {{{

let s:DEFAULT_OPTIONS = {
      \   'filetypes': {
      \     'ruby': {'comment_format': '# %s'}
      \   },
      \   'shebang_pattern': '^#!',
      \   'is_comment_patten': '\v((en|\s)coding:\s|fileencoding=)',
      \   'encodings': [
      \     {
      \       'name':    'non-ascii',
      \       'pattern': '[^\d0-\d128]',
      \       'comment': 'encoding: utf-8'
      \     },
      \   ]
      \ }
let s:OPTION_PREFIX = 'ruby_enccomment'
lockvar! s:OPTION_PREFIX s:DEFAULT_OPTIONS

" }}} Constants


" Main Functions: {{{

function! ruby_enccomment#do(...) "{{{
  let verbose         = a:0 > 0 ? a:1 : 1
  let update_in_place = a:0 > 1 ? a:2 : 0
  let found = 0
  let filetype_options = s:filetype_option(&filetype)
  if !empty(filetype_options)
    let is_comment_patten = s:option('is_comment_patten')
    for encoding in s:option('encodings')
      if search(encoding.pattern, 'cnw') > 0
        let comment_text = printf(filetype_options.comment_format, encoding.comment)
        let is_comment_patten = get(
              \   encoding,
              \   'is_comment_patten',
              \   is_comment_patten
              \ )

        let target_line = (getline(1) =~ s:option('shebang_pattern')) ? 2 : 1
        if getline(target_line) =~ is_comment_patten && s:is_in_comment(target_line)
          if getline(target_line) != comment_text
            call setline(target_line, comment_text)
          endif
        else
          call append(target_line - 1, comment_text)
        endif

        let found = 1

        if update_in_place > 0
          update
        endif
      endif
      break
    endfor
  endif
  if verbose && !found
    echomsg 'No need to insert magic comment.'
  endif
endfunction "}}}

" }}} Main Functions


" Utils: {{{

function! s:option(key) "{{{
  return get(g:, s:OPTION_PREFIX . a:key, get(s:DEFAULT_OPTIONS, a:key))
endfunction "}}}


function! s:filetype_option(type) "{{{
  let types = s:option('filetypes')
  return get(types, a:type, {})
endfunction "}}}


function! s:is_in_comment(...) "{{{
  let line = a:0 > 0 ? a:1 : line(".")
  let col = a:0 > 1 ? a:2 : indent(line) + 1
  let in_comment = 0
  for syn in synstack(line, col)
    if synIDattr(synIDtrans(syn), "name") ==# 'Comment'
      let in_comment = 1
    endif
  endfor
  return in_comment
endfunction "}}}

" }}} Utils
