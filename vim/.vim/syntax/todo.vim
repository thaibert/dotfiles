"
" Vim syntax file for .todo files
" Inspired by https://vim.fandom.com/wiki/Creating_your_own_syntax_files
"

" Keywords
syn keyword stillTodo TODO
syn match markCompleted "DONE.*$"

" Highlighting
hi def link stillTodo Comment
hi def link markCompleted Constant

