\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{academica}


\LoadClass[12pt,a4paper]{book}
%\LoadClass[oneside,12pt]{book}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% PACKAGES %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{kvoptions} % allows passing arguments to class options

\RequirePackage{geometry} % sets page geometry style
\RequirePackage{titlesec} % easily modify appereance of chapters and sections
\RequirePackage{titletoc} % easily modify appereance of tableofcontents

\RequirePackage{graphicx} % allow use of \includegraphics
\RequirePackage{float} % floating positioning for images, ..
\RequirePackage{caption} % provide captions (images, tables, ..)
\RequirePackage{subcaption} % provides multiple captions

\RequirePackage[backend=biber,style=numeric,maxbibnames=99,doi=true,eprint=true,sorting=none]{biblatex} % bibliography management

\RequirePackage{xcolor} % provides common colornames, plus allows definition of custom colors
\RequirePackage{tcolorbox} % creation of colored boxes

\RequirePackage{mathtools,amssymb} % math environments (equation, ..) and math symbols

\RequirePackage{tikz} % creation of tikz pictures
\usetikzlibrary{shadows} % adds shadow option into tikz pictures
\RequirePackage{pgfplots} % extend tikz by adding plots
\pgfplotsset{compat=1.18} % sets pgfplots compat version
\RequirePackage{siunitx} % units of measure (seconds, ...)

\RequirePackage{xspace} %provides \xspace, which adds space if no punctuation follows the commands

\RequirePackage[figure,table]{totalcount} % get total occurences of figures and tables (used in TOC)

% \hypersetup{
% 	colorlinks=true,
%   % allcolors=fg,
%   linkcolor=darkviolet,
%   citecolor=blueb,
% 	bookmarksnumbered=true,
% 	bookmarksopen=true
% }

% \RequirePackage{booktabs} % rearrange column and line in tabular




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% BASIC CLASS OPTIONS %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Basic options without parameters
\newif\ifacademica@pdfa
\DeclareOption{pdfa}{\academica@pdfatrue} % class option pdfa
\newif\ifacademica@light
\DeclareOption{light}{\academica@lighttrue} % class option light
\ProcessOptions\relax

% Sets if the generated output should be a `pdfa`
\ifacademica@pdfa
  \RequirePackage[a-1b]{pdfx} % generates pdfa output
  \RequirePackage[pdfa]{hyperref} % management of hyperlinks, plus autogeneration of bookmarks
\else
  \RequirePackage{hyperref} % management of hyperlinks, plus autogeneration of bookmarks
\fi




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% PARAMETERED CLASS OPTIONS %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% More complex options that allow passing strings
\SetupKeyvalOptions{prefix={academica@}}
\DeclareStringOption[]{banner}[] % class option banner
\ProcessKeyvalOptions{academica}\relax




%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%  FONTS  %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%

% Sets text to a light font.
% We firstly load `cmbright` that sets both text and math, to have a light math, matching the SopiaPro style.
% Then we overwrite the text font with SofiaPro.
\ifacademica@light
  % Set font to use Computer Modern Bright (works also with pdfLatex)
  \RequirePackage{cmbright} % light version of Computer Modern (default LaTex font)

  % Set font to use SofiaPro (need LuaLatex/XeLatex engine)
  \RequirePackage{fontspec} % allow to specify custom font

  % Sets mono font i.e. typewriter
  \setmonofont[
      Path = fonts/Monofur/,
      UprightFont = *Regular,
      ItalicFont = *Italic,
      BoldFont = *Bold,
      Extension = .ttf
  ]{MonofurNerdFontMono-}

  % Sets sans serif font, used by Small caps or part of title/headers
  \setsansfont[
      Path = fonts/SofiaPro/,
      UprightFont = *ExtraLight,
      ItalicFont = *ExtraLight-Italic,
      BoldFont = *Medium,
      BoldItalicFont = *Medium-Italic,
      Extension = .otf
  ]{SofiaPro}
  
  % Sets roman font i.e. default text font (called upright)
  \setmainfont[
      Path = fonts/SofiaPro/,
      UprightFont = *ExtraLight,
      ItalicFont = *ExtraLight-Italic,
      BoldFont = *Medium,
      BoldItalicFont = *Medium-Italic,
      Extension = .otf
  ]{SofiaPro}

\else
\fi





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% COLORS %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%\definecolor{white}{HTML}{F5F5F5}
%\definecolor{black}{HTML}{1D1D1C}
\definecolor{graydark}{HTML}{484848}
\definecolor{lilla}{HTML}{B4B5EE}
\definecolor{purple}{HTML}{B4B5EE}
\definecolor{blue}{HTML}{98CEF3}
\definecolor{deepsea}{HTML}{123499}
\definecolor{pink}{HTML}{F7ABDC}
\definecolor{red}{HTML}{E95678}

\colorlet{accent}{lilla!160}
\colorlet{accentlight}{lilla!30}
\colorlet{accentmedium}{lilla!240}
\colorlet{accentdark}{lilla!320}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% PAGING %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% \def\academica@unisep{.5em}
% \def\academica@se@and{.2ex}
% \def\academica@se@qual{1ex}
% \def\academica@se@sep{2em}
 
\geometry{
    hcentering,
    bindingoffset=.025\paperwidth,
    outer=.075\paperwidth,
    nofoot,nomarginpar,
    vdivide={.08\paperheight,*,.06\paperheight}
}

% create storage for titles
\newcommand{\chaptertitle}{}
\newcommand{\sectiontitle}{}

% update stored chapter title whenever \chapter is used
\renewcommand{\chaptermark}[1]{
  \markboth{#1}{}
  \renewcommand{\chaptertitle}{#1}
  % reset section title when a new chapter starts
  \renewcommand{\sectiontitle}{}
}

% update stored section title whenever \section is used
\renewcommand{\sectionmark}[1]{
  \markright{#1}
  \renewcommand{\sectiontitle}{#1}
}

% custom definition of header
\def\header{
  \ifnum\value{section}=0
    \MakeUppercase{\chaptertitle}
  \else
    \MakeUppercase{\chaptertitle} \ --- \ \textit{\sectiontitle}
  \fi
}

\let\ps@plain\ps@empty%

% new page style `academica`
\@namedef{ps@academica}{
  %\let\@oddfoot\@empty
  %\let\@evenfoot\@empty
  %\let\@mkboth\markboth
  \def\@evenhead{\thepage\hfill{\footnotesize \textcolor{accentdark}{\header}}}%
  \def\@oddhead{{\footnotesize \textcolor{accentdark}{\header}}\hfill\thepage}%
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% ENVIRONMENT %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\acknowledgements{\chapter*{\textcolor{accentmedium}{Acknowledgements}}}
\def\abstract{\chapter*{\textcolor{accentmedium}{Abstract}}\addcontentsline{toc}{chapter}{Abstract}}
\def\summary{\chapter{\textcolor{accentmedium}{Summary}}}

\newenvironment{titlelike}[1]{
    \cleardoublepage\thispagestyle{empty}
    \def\academica@titlelike{#1}
    \vspace*{\z@\@plus.3fil}
    \begin{\academica@titlelike}
}{
    \end{\academica@titlelike}
    \vspace*{\z@\@plus.6fil}
    \newpage\thispagestyle{empty}
}

\newenvironment{dedication}{\begin{titlelike}{flushright}\begin{itshape}}{\end{itshape}\end{titlelike}}

\tcbuselibrary{skins}
% \tcbuselibrary{skins,listings,breakable}
\newtcolorbox{accentbox}[3][]{
  enhanced,
  attach boxed title to top left={xshift=3mm,yshift=-3mm,yshifttext=-1mm},
  colback=#3!30,
  colframe=#3!160,
  colbacktitle=white,
  coltitle=#3!240,
  coltext=black,
  arc=4mm,boxrule=2pt,
  title=\textbf{#2}\ifx#1\@empty \else : \textit{#1}\fi,
  halign=flush left,
  boxed title style={size=small,colframe=#3!160,arc=2mm}
}

\newenvironment{definition}[1][]{\begin{accentbox}[#1]{Definition}{lilla}}{\end{accentbox}}
\newenvironment{note}[1][]{\begin{accentbox}[#1]{Note}{gray}}{\end{accentbox}}

% custom title body:
% chaptertitle <empty> bigchapternumber
\newcommand{\chaptertitlemain}[1]{
  #1
  \hfill
  {\fontsize{100}{60}\selectfont\textcolor{accent}{\thechapter}}
}

\newcommand{\chaptertitleback}[1]{
  #1
}

\newcommand{\academicachaptermain}{
  \titleformat{\chapter}[block]
    {\huge\bfseries} % Format of the whole line
    {} % Label
    {0pt} % Separation between label and title body
    {\chaptertitlemain} % title body
}

\newcommand{\academicachapterback}{
  \titleformat{\chapter}[block]
    {\huge\bfseries} % Format of the whole line
    {} % Label
    {0pt} % Separation between label and title body
    {\chaptertitleback} % title body
}

\let\oldfrontmatter\frontmatter
\renewcommand{\frontmatter}{
  \pagestyle{empty}
  \oldfrontmatter
}

\let\oldmainmatter\mainmatter
\renewcommand{\mainmatter}{
  \pagestyle{academica}
  \setcounter{page}{0}
  \oldmainmatter
  \academicachaptermain
}

\let\oldbackmatter\backmatter
\renewcommand{\backmatter}{
  \pagestyle{empty}
  \oldbackmatter
  \academicachapterback
}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%   TITLE   %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\@date{
  \begingroup
    \expandafter\advance\expandafter\year\ifnum\month>3
      -1
    \else
      -2
    \fi
    \the\year-\advance\year1 \the\year
  \endgroup
}

\def\@banner{
  \ifx\academica@banner\@empty
    \textcolor{white}{\rule{\textwidth}{40pt}}
  \else
    \@for\@ban:=\academica@banner\do{\includegraphics[width=\textwidth]{banners/\@ban.pdf}\\}
  \fi
  \vfill
}

% Defines a new field 
\newcommand{\deffield}[1]{
  % Define storage macro \@<name> (empty initially)
  \expandafter\newcommand\csname @#1\endcsname{}
  % Define setter: \name{<value>} sets \@<name>
  \expandafter\newcommand\csname #1\endcsname[1]{
    \expandafter\gdef\csname @#1\endcsname{##1}
  }
}

% Define multiple fields by extending `\deffield`.
% Takes a comma-separated list as input
\newcommand{\deffields}[1]{
  \@for\@field:=#1\do{
    \expandafter\deffield\expandafter{\@field}
  }
}

% Simply prints the field value after printing the field name
\def\show#1{
  \if\csname @#1\endcsname\@empty
  \else
    \textcolor{accentdark}{\textsc{\csname #1name\endcsname}}\\
    \textit{\csname @#1\endcsname}\par
    \vskip2em\relax
  \fi
}

\newcount\@numitems

\newcommand{\countitems}[1]{
  \@numitems\z@
  \expandafter\@for\expandafter\@item\expandafter:\expandafter=\csname @#1\endcsname\do{\advance\@numitems\@ne}
}

% Alternative version of `show` that use a singular/plural version of the field name
% depending on the number of elements.
\def\shows#1{
  \if\csname @#1\endcsname\@empty
  \else
    \countitems{#1}
    \ifnum\the\@numitems>1
      \textcolor{accentdark}{\textsc{\csname #1name\endcsname s}}\\
    \else
      \textcolor{accentdark}{\textsc{\csname #1name\endcsname}}\\
    \fi
    \expandafter\@for\expandafter\entry\expandafter:\expandafter=\csname @#1\endcsname\do{
      \textit{\entry}\par
    }
    \vskip2em\relax
  \fi
}

% Custom field definitions
\deffields{overtitle,supervisor,cosupervisor,tutor,institutecontacts,authorcontacts}

% Field names
\def\authorname{Author}
\def\supervisorname{Supervisor}
\def\cosupervisorname{Co-Supervisor}
\def\tutorname{Tutor}
%\def\datename{Academic Year}
%\def\shortdatename{A.Y.}
\def\institutecontactsname{Institute Contacts}
\def\authorcontactsname{Author's Contacts}

\gdef\uniudcontacts{
	Universit\`a degli Studi di Udine: Dipartimento di Scienze Matematiche, Informatiche e Fisiche\\
	Via delle Scienze, 206, 33100 Udine (IT)\\
	+39 0432 558400\\
  \href{mailto:info.dmif@uniud.it}{info.dmif@uniud.it}\\
	\@ifundefined{url}\texttt\url{https://www.dmif.uniud.it/}
}

\def\@rights{%
	\textcopyright\ \the\year\ \@author\\ This work is shared under the Creative Commons 4.0 License Attribution-NonCommercial-ShareAlike.%
}

\def\maketitle{
  \begin{titlepage}
    \noindent
    \begin{minipage}[t][\textheight][s]{\linewidth}
    	\sffamily
      {\@banner}
      \begin{center}
        {\textcolor{accentdark}{\textsc{\large \@overtitle}}\par}
        \vskip 1em\@plus1fill\relax
        {\fontsize{30}{20}\selectfont\bfseries\@title\par}
        \vskip 5em\@plus1fill\relax
        {\large
            \parbox[t]{0.40\linewidth}{
                \shows{author}
            }
            \qquad
            \parbox[t]{0.40\linewidth}{
                \shows{supervisor}
                \shows{cosupervisor}
                \shows{tutor}
            }
        }
        \par\vskip 1em\@plus1fill\relax
        {\large\@date}\par
      \end{center}
    \end{minipage}
  \end{titlepage}
  {
    \parindent\z@\relax
    \show{institutecontacts}
    \show{authorcontacts}
    \ifx\@rights\@empty\else\vfill\@rights\par\fi
  }
}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%   TOC   %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\contentsmargin{0cm}

% edit appereance of `part` inside toc
\titlecontents{part}[-1pc]
{
  \addvspace{50pt}
	\begin{tikzpicture}[remember picture, overlay]
		\draw[fill=accent,draw=accent,rounded corners] (-4.5,-0.2) rectangle (-0.2,0.55);
    \pgftext[left,x=-1.6cm,y=0.15cm]{\textcolor{white}{\Large\sc\bfseries Part}};
	\end{tikzpicture}
  \large\sc\bfseries
}
{}
{}
{}

% edit appereance of `chapter` inside toc
\titlecontents{chapter}[5pc]
{
  \addvspace{30pt}
  \ifx\thecontentslabel\@empty
    \begin{tikzpicture}[remember picture, overlay]
	  	\draw[fill=accent,draw=accent,rounded corners] (-3.5,-0.2) rectangle (-0.7,0.55);
      \pgftext[left,x=-3.38cm,y=0.18cm]{\textcolor{white}{\Large\sc\bfseries Chapter}};
    \end{tikzpicture}\large\sc\bfseries
  \else
	  \begin{tikzpicture}[remember picture, overlay]
	  	\draw[fill=accent,draw=accent,rounded corners] (-3.5,-0.2) rectangle (-0.3,0.55);
      \pgftext[left,x=-3.38cm,y=0.18cm]{\textcolor{white}{\Large\sc\bfseries Chapter\ \thecontentslabel}};
    \end{tikzpicture}\large\sc\bfseries
  \fi
}
{}
{}
{
  \;\titlerule\;\large\sc\bfseries Page \thecontentspage
	\begin{tikzpicture}[remember picture, overlay]
		\draw[fill=black,draw=black] (4pt,0.2pt) rectangle (4,0.2pt);
	\end{tikzpicture}
}

% edit appereance of `section` inside toc
\titlecontents{section}[5pc]
{\addvspace{2pt}}
{\contentslabel[\thecontentslabel]{2pc}}
{}
{\hfill\small \thecontentspage}
[]

% edit appereance of `subsection` inside toc
\titlecontents{subsection}[5pc]
{\addvspace{2pt}}
{\scriptsize$\bullet$\quad\small}
{}
{\hfill\small \thecontentspage}
[]

% edit appereance of `figure` inside toc
\titlecontents{figure}[5pc]
{\addvspace{2pt}}
{\contentslabel[\thecontentslabel]{2pc}}
{}
{\hfill\small \thecontentspage}
[]

% edit appereance of `table` inside toc
\titlecontents{table}[5pc]
{\addvspace{2pt}}
{\contentslabel[\thecontentslabel]{2pc}}
{}
{\hfill\small \thecontentspage}
[]

\renewcommand{\listoffigures}{
  {
  \let\cleardoublepage\clearpage
	\chapter*{
	  \vspace*{-20\p@}
	  \begin{tikzpicture}[remember picture, overlay]
		  \draw[fill=accent,draw=accent,rounded corners] (10,-0.65) rectangle (20,1);
		  \pgftext[right,x=16.7cm,y=0.2cm]{\color{white}\Huge\sc\bfseries List of Figures};
	  \end{tikzpicture}
  }
  \@starttoc{lof}
  }
}

\renewcommand{\listoftables}{
  %\let\cleardoublepage\clearpage
	\chapter*{
	  \vspace*{-20\p@}
	  \begin{tikzpicture}[remember picture, overlay]
		  \draw[fill=accent,draw=accent,rounded corners] (10.5,-0.65) rectangle (20,1);
		  \pgftext[right,x=16.7cm,y=0.2cm]{\color{white}\Huge\sc\bfseries List of Tables};
	  \end{tikzpicture}
  }
  \@starttoc{lot}
}

% move contents title on the right then prints TOC with figures and tables
\renewcommand{\tableofcontents}{
	\chapter*{
	  \vspace*{-20\p@}
	  \begin{tikzpicture}[remember picture, overlay]
		  \draw[fill=accent,draw=accent,rounded corners] (12.2,-0.65) rectangle (20,1);
		  \pgftext[right,x=16.7cm,y=0.2cm]{\color{white}\Huge\sc\bfseries \contentsname};
	  \end{tikzpicture}}
	\@starttoc{toc}
  \iftotalfigures\listoffigures\fi
  \iftotaltables\listoftables\fi
  \clearpage
}






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%   REFERENCES   %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\addbibresource{bib/abbrev0.bib}
\addbibresource{bib/main.bib}


\def\references{
  \chapter*{\textcolor{accentmedium}{Bibliography}}\addcontentsline{toc}{chapter}{Bibliography}
  \nocite{*} % adds all bibliography entries, even not cited
  \printbibliography[heading=none]
}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%   COMMON SHORTCUTS   %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\ie}{\textit{i.e.}\xspace}
\newcommand{\eg}{\textit{e.g.}\xspace}
\newcommand{\st}{\textit{s.t.}\xspace}

