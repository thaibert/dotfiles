syntax match conventional_type_startingwhitespace "^\s*"         nextgroup=conventional_type        contained containedin=gitcommitFirstLine
syntax match conventional_type                    "\k\+\((\)\@=" nextgroup=conventional_scope_start contained
syntax match conventional_scope_start "("     nextgroup=conventional_scope     contained
syntax match conventional_scope       "[^)]*" nextgroup=conventional_scope_end contained
syntax match conventional_scope_end   "):"    nextgroup=conventional_subject   contained skipwhite
syntax match conventional_subject         ".\{1,60}" contained nextgroup=conventional_subject_overrun
syntax match conventional_subject_overrun ".*"       contained

highlight default link conventional_type_startingwhitespace QuickFixLine
highlight default link conventional_type Title
highlight default link conventional_scope MoreMsg
highlight default link conventional_subject Normal
hi def link conventional_subject_overrun CursorLineSign
