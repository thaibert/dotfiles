set relativenumber " Enable line numbering
set number         " ... and have the cursor's line show absolute
syntax on

set tabstop=2       " Base tab width
set shiftwidth=0    " Inherit tabstop
set expandtab       " Place spaces instead when tabbing
set softtabstop=-1  " Delete $shiftwidth spaces at a time when backspacing
set smartindent
set list              " Set up for displaying tabs explicitly
set listchars=tab:>-  " Set tab character display
" If the need occurs for replacing tabs in a file with spaces, use :retab


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

" Filetype-specific setup
filetype on
filetype plugin on
filetype indent on " file type based indentation
autocmd FileType make set noexpandtab shiftwidth=4 softtabstop=0


" Plugin section
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
  Plug 'yuttie/comfortable-motion.vim'
call plug#end()

let g:comfortable_motion_friction = 80.0
let g:comfortable_motion_air_drag = 2.0
let g:comfortable_motion_no_default_key_mappings = 1
let g:comfortable_motion_impulse_multiplier = 1
nnoremap <silent> <C-d> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 2)<CR>
nnoremap <silent> <C-u> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -2)<CR>
nnoremap <silent> <C-f> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 4)<CR>
nnoremap <silent> <C-b> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -4)<CR>


