\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{haxe}
\LoadClass[oneside]{book}

\RequirePackage[usenames,dvipsnames]{xcolor}
\RequirePackage{listings}
\RequirePackage{framed}
\RequirePackage{palatino}
\RequirePackage{courier}
\RequirePackage{underscore}
\RequirePackage{fullpage}
\RequirePackage[colorlinks=true,linkcolor=blue]{hyperref}
\RequirePackage[nameinlink]{cleveref}

\setlength{\marginparwidth}{4cm}

% Colors

\definecolor{bgcolor}{gray}{0.85}
\definecolor{kwdcolor}{HTML}{0000FF}
\definecolor{identcolor}{rgb}{0,0,0}
\definecolor{commentcolor}{HTML}{008000}
\definecolor{stringcolor}{HTML}{a31515}

% Custom commands

\newcommand{\target}[1]{#1} % when mentioning Javascript, Php etc.
\newcommand{\type}[1]{\texttt{#1}} % when mentioning types
\newcommand{\expr}[1]{\texttt{#1}} % Haxe expressions
\newcommand{\since}[1]{\noindent\textbf{Since Haxe #1}\\} % to generate ``Since Haxe #1''
\newcommand{\Fullref}[1]{\nameref{#1} (\Cref{#1})} % full references
\newcommand{\tref}[2]{#1 (\ref{#2})} % general references
\newcommand{\state}[1]{} % state of the section
\newcommand{\ic}[1]{\texttt{#1}} % shortcut because \texttt is awkward to type
\newcommand{\flag}[2]{} % pass custom flags to converter

% Listings

\lstdefinelanguage{haxe}{
  keywords={function, class, var, if, else, while, do, for, break, continue, return, extends, implements, import, switch, case, default, static, public, private, try, catch, new, this, throw, extern, enum, in, interface, untyped, cast, override, typedef, dynamic, package, inline, using, null, true, false, abstract, macro},
  sensitive=true,
  comment=[l]{//},
  morecomment=[s]{/*}{*/},
  morestring=[b]',
  morestring=[b]",
}

\lstset{
	language=Haxe,
	basicstyle=\ttfamily,
  keywordstyle=\color{kwdcolor},
  identifierstyle=\color{identcolor},
	commentstyle=\color{commentcolor},
	stringstyle=\color{stringcolor},
	backgroundcolor=\color{bgcolor},
	extendedchars=true,
	showstringspaces=false,
	showspaces=false,
	numbers=left,
	numberstyle=\footnotesize,
	numbersep=9pt,
	tabsize=4,
	breaklines=true,
	showtabs=false,
	captionpos=b,
}

\newcommand{\haxe}[2][]{%
    \lstinputlisting[#1]{#2}%
}

% Boxes

\newenvironment{myshaded}
  {\def\FrameCommand{\fboxsep=\topsep\colorbox{bgcolor}}%
  \MakeFramed {\advance\hsize-\width \FrameRestore}}%
 {\endMakeFramed}

\newcommand{\define}[4][Definition]
	{\begin{myshaded}\noindent\textbf{#1: #2}\par\nobreak\noindent\ignorespaces#4\label{#3}\end{myshaded}}

\newcommand{\trivia}[2]
	{\begin{myshaded}\noindent\textbf{Trivia: #1}\par\nobreak\noindent\ignorespaces#2\end{myshaded}}