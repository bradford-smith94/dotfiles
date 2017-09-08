" Bradford Smith
" 09/08/2017
" ~/.vim/custom/templates/editorconfig.vim
" this file is sourced when creating a new .editorconfig

" :insert will insert all following lines until it reaches a line with just a
" "." on it
:insert
# see: http://editorconfig.org

# specify that this is the top-most EditorConfig file
root = true

# rules for all files
[*]
charset = utf-8
#or latin1, utf-16be, utf-16le

end_of_line = lf
#or crlf, cr

insert_final_newline = true

trim_trailing_whitespace = true

indent_style = space
#or tab

indent_size = 4
#or tab

tab_width = 4
#defaults to indent_size

# the value 'unset' can be used on all options to disable them
.
