" this is a file sourced when creating a new LaTeX (*.tex) file

" :insert will insert all following lines until it reaches a line with just a
" "." on it
:insert
% Bradford Smith
% <File>
% Date:
%===============

% global document styles =======================================================

\\documentclass[11pt, letterpaper]{article}

\\usepackage[letterpaper, margin=0.5in]{geometry}

\\usepackage[utf8]{inputenc}

\\usepackage[T1]{fontenc}

\\usepackage{tgbonum}

\\usepackage{textcomp}

\\pagestyle{empty}

\\setlength{\tabcolsep}{0em}


% document begins here =========================================================

\\begin{document}

\\end{document}

.
" ended inserting, update "Date:" with the current date as mm/dd/yyyy
:%s/Date:/\=strftime("%m\/%d\/%Y", localtime())/
" expand <File> with the filename
:execute "normal! ggjfFca<".expand('%:t')
