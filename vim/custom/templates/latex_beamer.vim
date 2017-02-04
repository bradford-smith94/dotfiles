" Bradford Smith
" ~/.vim/custom/templates/latex_beamer.vim
" 02/04/2017
" this file is sourced when creating a new LaTeX beamer presentation

:insert

% global document styles =======================================================

\\documentclass{beamer}

\\usepackage{pgfpages}

\\mode<presentation>
{%

\   \usetheme{default}

\   \usecolortheme{default}

\   \usefonttheme{default}

\   \setbeamertemplate{navigation symbols}{}

\   \setbeamertemplate{caption}[numbered]

\   \setbeamertemplate{footline}[]

\   \setbeamertemplate{note page}[plain]


\   \setbeameroption{show notes on second screen=right}
}


\\usepackage[english]{babel}

\\usepackage[T1]{fontenc}

\\usepackage[utf8x]{inputenc}

\\usepackage{graphicx}

\\usepackage{xcolor}

\\usepackage{transparent}


% custom macros ================================================================
% colored inline code formatting

\\definecolor{codebg}{RGB}{225,225,225}

\\definecolor{codefg}{RGB}{200,40,90}

\\newcommand{\code}[1]{\colorbox{codebg}{\textcolor{codefg}{\texttt{#1}}}}

% simple blue colored URLs

\\newcommand{\simpleURL}[1]{{\color{blue}\url{#1}}}

% other beamer configuration ===================================================

\\title[]{}

\\subtitle{}

\\author{}

\\institute{}

\\date{\today}


% presentation begins here =====================================================

\\begin{document}


\\begin{frame}

\   \titlepage{}

\\end{frame}


\\end{document}
.
