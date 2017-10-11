% Bradford Smith
% ~/texmf/tex/latex/homework.cls
% 10/10/2017
% Custom homework class built on article

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{homework}[2017/10/10 Class for typesetting my homework]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ExecuteOptions{12pt, letterpaper}
\ProcessOptions\relax

\LoadClass{article}
\RequirePackage[letterpaper, margin=1.0in]{geometry}
\RequirePackage[T1]{fontenc}
\RequirePackage{setspace}
\RequirePackage{xcolor}

% colored inline code formatting
\definecolor{codebg}{RGB}{225,225,225}
\definecolor{codefg}{RGB}{200,40,90}
\newcommand{\code}[1]{\colorbox{codebg}{\textcolor{codefg}{\texttt{#1}}}}

\pagestyle{empty}
\setlength{\parindent}{0.5in}

\def\assignment#1{\def\@assignment{#1}}

\renewcommand{\maketitle}{%
    \noindent{\@author}\\
    \noindent{\@assignment}\\
    \noindent{\@date}
    \if\@title\empty\else\\\centerline{\@title}\fi
}

\renewcommand{\section}{%
    \@startsection
    {section}{1}{0pt}{-1.5ex plus -1ex minus -.2ex}%
    {1ex plus.2ex}{\noindent\large\textbf}%
}
