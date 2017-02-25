" Bradford Smith
" ~/.vim/custom/templates/latex_article.vim
" 02/04/2017
" this file is sourced for creating a new LaTeX article

:insert

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