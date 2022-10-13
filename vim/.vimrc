set relativenumber " Enable line numbering
set number         " ... and have the cursor's line show absolute
syntax on


function GetLineEnding()
  if ( &fileformat == "unix" )
    return "LF"
  elseif ( &fileformat == "dos" )
    return "CRLF"
  endif
endfunction
" Statusline config
  set laststatus=2 " Always show status bar
  set statusline=
  " left side
  set statusline+=%<
  set statusline+=%f " Show file name
  set statusline+=%(\ %m%)%(\ %r%) " [modified?] [readonly?]
  " right side
  set statusline+=%=
  set statusline+=%(%3l:%c%V\ (%P)%)%6(%) " line:column (xx%)
  set statusline+=0x%02B%6(%)          " current byte under cursor (in hex)
  set statusline+=%([%{&fileencoding?&fileencoding:&encoding}\ %{GetLineEnding()}]%)

" Misc other setup
set scrolloff=10


set hlsearch   " Highlight all occurrences when searching
set ignorecase " Case-insensitive search
set smartcase  " ... but turn on case-sensitive search when searching with any capital letters
" below: temporarily remove highlighting of searched term in command mode with Enter
nnoremap <CR> :nohlsearch<CR><CR>

