"
" Vim syntax file for .todo files
" Inspired by https://vim.fandom.com/wiki/Creating_your_own_syntax_files
"

" Keywords
syn keyword ok_keyword OK
syn keyword stillTodo TODO
syn match markCompleted "DONE.*$"

syn match comment_to_eol "\s//.*"

syn match h1_pound "^\s*#\+.*$"
syn match h1_eq "^\s*=\+[^=]\+=\+"

syn match datetime "[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}\([T ][0-9]\{2\}:[0-9]\{2\}:[0-9]\{1,2\}\([,.][0-9]\+\)\?\)\?"

syn match highlight_line "^.*§.*$"

" Highlighting
hi def link ok_keyword Type
hi def link stillTodo Comment
hi def link markCompleted Constant

hi def link comment_to_eol Identifier

hi def link h1_pound PreProc
hi def link h1_eq Statement

hi def link datetime Type
hi def link highlight_line Constant

