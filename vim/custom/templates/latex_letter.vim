" Bradford Smith
" ~/.vim/custom/templates/latex_letter.vim
" 10/20/2017
" this file is sourced for creating a new LaTeX letter

:insert

% global document styles =======================================================

\\documentclass[12pt, letterpaper]{letterpaper}

\\usepackage[letterpaper, top=0.5in]{geometry}

\\usepackage[utf8]{inputenc}

\\usepackage[T1]{fontenc}


\\newcommand{\phone}{}

\\newcommand{\email}{}

\\signature{Bradford O. Smith}

\\address{%
    Bradford O. Smith\\
}


% letter begins here ===========================================================

\\begin{document}

\\begin{letter}{%
    To\\
    ToAddr\\
    }

\\opening{Dear \dots{}}

% body


\\closing{Sincerely,}

\\end{letter}

\\end{document}
.

