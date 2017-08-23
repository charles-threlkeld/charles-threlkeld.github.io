◊(local-require racket/file
                racket/system
                racket/list)
◊(define latex-source ◊string-append{
\documentclass[10pt]{article}

\usepackage[hmargin=1.25cm, vmargin=1.5cm]{geometry}

\usepackage{marvosym}
\usepackage{ifsym}
\usepackage{tabularx}
\usepackage{textcomp}

\usepackage[usenames,dvipsnames]{xcolor}

\usepackage{fontspec,xltxtra,xunicode}
\defaultfontfeatures{Mapping=tex-text}
\setromanfont[Mapping=tex-text]{Charter}
\setsansfont[Scale=MatchLowercase,Mapping=tex-text]{Charter}

\usepackage{hyperref}
\definecolor{linkcolor}{HTML}{506266}
\definecolor{shade}{HTML}{F5F2B8}
\definecolor{text1}{HTML}{2b2b2b}
\definecolor{headings}{HTML}{701112}

\hypersetup{colorlinks,breaklinks, urlcolor=linkcolor, linkcolor=linkcolor}

\usepackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}

\renewcommand{\headrulewidth}{0pt}

\usepackage{titlesec}

\titleformat{\section}{\color{headings}
  \scshape\Large\raggedright}{}{0em}{}[\color{black}\titlerule]

\titlespacing{\section}{0pt}{0pt}{5pt}

\begin{document}

\color{text1}

◊(apply string-append (filter string? (flatten doc)))

\end{document}})
◊(define working-directory
   (build-path (current-directory) "pollen-latex-work"))
◊(unless (directory-exists? working-directory)
   (make-directory working-directory))
◊(define temp-ltx-path (build-path working-directory "temp.tex"))
◊(display-to-file latex-source temp-ltx-path #:exists 'replace)
◊(define command (format "xelatex --output-directory '~a' '~a'"
                         working-directory temp-ltx-path))
◊(if (system command)
     (file->bytes (build-path working-directory "temp.pdf"))
     (error "xelatex: rendering error"))
