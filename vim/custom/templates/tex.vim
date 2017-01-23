" Bradford Smith
" ~/.vim/custom/templates/tex.vim
" 01/23/2017
" this file is sourced when creating a new LaTeX (*.tex) file

" :insert will insert all following lines until it reaches a line with just a
" "." on it
:insert
% Bradford Smith
% <File>
% Date:
%===============

% global document styles =======================================================

\\documentclass[12pt, letterpaper]{article}

\\usepackage[letterpaper, margin=1.0in]{geometry}

\\usepackage[utf8]{inputenc}

\\usepackage[T1]{fontenc}

\\usepackage{textcomp}

\\usepackage{xcolor} %for colored code formatting

\\pagestyle{empty}

\\setlength{\tabcolsep}{0em}


% custom macros ================================================================
% simple inline code formatting (using typewriter font)
%\newcommand{\code}[1]{\texttt{#1}}

% colored inline code formatting

\\definecolor{codebg}{RGB}{225,225,225}

\\definecolor{codefg}{RGB}{200,40,90}

\\newcommand{\code}[1]{\colorbox{codebg}{\textcolor{codefg}{\texttt{#1}}}}


% document begins here =========================================================

\\begin{document}

\\end{document}

.
" ended inserting, update "Date:" with the current date as mm/dd/yyyy
:%s/Date:/\=strftime("%m\/%d\/%Y", localtime())/
" expand <File> with the filename
:execute "normal! ggjfFca<".expand('%:t')

"this sets the filetype correctly right away
setlocal ft=tex
