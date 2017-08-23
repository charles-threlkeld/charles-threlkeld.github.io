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

◊(local-require racket/list)
  ◊(apply string-append (filter string? (flatten doc)))

\end{document}
