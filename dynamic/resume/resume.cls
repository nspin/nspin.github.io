\ProvidesClass{resume}
\LoadClass{article}

\usepackage{fontawesome}

\usepackage[hmargin=1.25cm, vmargin=0.75cm]{geometry}
\usepackage[hidelinks]{hyperref}

\usepackage[usenames,dvipsnames]{xcolor} 
\definecolor{date}{HTML}{666666} 
\definecolor{primary}{HTML}{2b2b2b} 
\definecolor{headings}{HTML}{6A6A6A}
\definecolor{subheadings}{HTML}{333333}

\usepackage[absolute]{textpos}
\usepackage[UKenglish]{isodate}
\setlength{\TPHorizModule}{1mm}
\setlength{\TPVertModule}{1mm}
\newcommand{\lastupdated}{
  \begin{textblock}{60}(155,5)
    \color{date}\fontsize{8pt}{10pt}\selectfont 
    Last Updated on \today
  \end{textblock}
}

\newcommand{\namesection}[2]{
  \centering {
    \color{headings}
    \fontsize{40pt}{60pt}
    \selectfont #1 
  } \\[5pt]
    \centering {
    \color{headings}
    \fontsize{11pt}{14pt}\selectfont #2
  }
  \noindent\makebox[\linewidth]{\color{headings}\rule{\paperwidth}{0.4pt}}
  \vspace{-15pt}
}

\usepackage{titlesec}
\titlespacing{\section}{0pt}{0pt}{0pt} 
\titlespacing{\subsection}{0pt}{0pt}{0pt}
\newcommand{\sectionsep}{\vspace{8pt}}

\titleformat{\section}{\color{headings}
\scshape\fontsize{16pt}{24pt}\selectfont \raggedright\uppercase}{}{0em}{}

\titleformat{\subsection}{
\color{subheadings}\fontsize{12pt}{12pt}\selectfont\bfseries\uppercase}{}{0em}{}

\newcommand{\runsubsection}[1]{
\color{subheadings}\fontsize{12pt}{12pt}\selectfont\bfseries\uppercase{#1}\normalfont}

\newcommand{\descript}[1]{
\color{subheadings}\raggedright\scshape\fontsize{11pt}{13pt}\selectfont{#1\\}\normalfont}

\newcommand{\location}[1]{
\color{headings}\raggedright\fontsize{10pt}{12pt}\selectfont{#1\\}\normalfont}

\newcommand{\sep}{\textbullet{} }

\newcommand{\metanote}[1]{
{\footnotesize \textit{\textbf{#1}}}\\}

\newenvironment{tightemize}{
\vspace{-\topsep}\begin{itemize}\itemsep1pt \parskip0pt \parsep0pt}
{\end{itemize}\vspace{-\topsep}}
