"
" Vim syntax file for .todo files
" Inspired by https://vim.fandom.com/wiki/Creating_your_own_syntax_files
"

" Keywords
syn keyword stillTodo TODO
syn match markCompleted "DONE.*$"

syn match comment_to_eol "\s//.*"

syn match h1_pound "^\s*#\+.*$"
syn match h1_eq "^\s*=\+[^=]\+=\+"

" Highlighting
hi def link stillTodo Comment
hi def link markCompleted Constant

hi def link comment_to_eol Identifier

hi def link h1_pound PreProc
hi def link h1_eq Statement

