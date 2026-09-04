\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{academica}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% BASIC CLASS OPTIONS %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Basic options without parameters
\newif\ifacademica@pdfa
\DeclareOption{pdfa}{\academica@pdfatrue}
\newif\ifacademica@oneside
\DeclareOption{oneside}{\academica@onesidetrue\PassOptionsToClass{oneside}{book}}
\newif\ifacademica@defaultfont
\DeclareOption{defaultfont}{\academica@defaultfonttrue}
\ProcessOptions\relax

\LoadClass[a4paper,12pt]{book}
%\LoadClass[a4paper,12pt,xcolor=table]{book}

\ifacademica@oneside
  \setlength{\parindent}{0pt}
\fi



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% PARAMETERED CLASS OPTIONS %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{kvoptions} % allows passing arguments to class options
\SetupKeyvalOptions{prefix={academica@}}
\DeclareStringOption[]{banner}[]
\ProcessKeyvalOptions{academica}\relax



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% PACKAGES %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Sets if the generated output should be a `pdfa`
\ifacademica@pdfa
  \RequirePackage[a-1b]{pdfx} % generates pdfa output
  \RequirePackage[pdfa]{hyperref}
\else
  \RequirePackage{hyperref} % management of hyperlinks, plus autogeneration of bookmarks
\fi

\RequirePackage{geometry} % sets page geometry style
\RequirePackage{titlesec} % easily modify appereance of chapters and sections
\RequirePackage{titletoc} % easily modify appereance of tableofcontents

\RequirePackage{graphicx} % allow use of \includegraphics
\RequirePackage{float} % floating positioning for images, ..
\RequirePackage{caption} % provide captions (images, tables, ..)
\RequirePackage{subcaption} % provides multiple captions

\RequirePackage[backend=biber,style=numeric,maxbibnames=99,doi=true,eprint=true,sorting=none]{biblatex} % bibliography management

\RequirePackage[table]{xcolor} % provides common colornames, plus allows definition of custom colors
\RequirePackage{tcolorbox} % creation of colored boxes

\RequirePackage{mathtools,amssymb} % math environments (equation, ..) and math symbols
% \RequirePackage{stmaryrd} % for llbracket, ie, [[, ]]

\RequirePackage{tikz} % creation of tikz pictures
\usetikzlibrary{shadows} % adds shadow option into tikz pictures
\usetikzlibrary{decorations.pathmorphing} % adds line path modification (for wavy lines)
\usetikzlibrary{positioning} % improved node positioning
% \usetikzlibrary{arrows}
% \usetikzlibrary{angles}
% \usetikzlibrary{calc} % allows calculations to change node positioning
% \usetikzlibrary{trees,patterns} % trees
% \usetikzlibrary{automata} % automata
% \usetikzlibrary{quantikz2} % quantum library

\RequirePackage{pgfplots} % extend tikz by adding plots
\pgfplotsset{compat=1.18} % sets pgfplots compat version
\RequirePackage{siunitx} % units of measure (seconds, ...)

\RequirePackage{booktabs, multirow} % improved tables (multicolumn, multiurow)
\RequirePackage{tabularx} % improved tabular
% \RequirePackage{array} % other tabular improvements like custom widths

\RequirePackage[figure,table]{totalcount} % get total occurences of figures and tables (used in TOC)

\RequirePackage{cancel} % for cancelling our math
\RequirePackage{listings} % for block of codes
\RequirePackage{adjustbox} % automatically adjust width of figure/tikz
\RequirePackage{xspace} % for space only if no punctuation follows
% \RequirePackage{enumitem} % improved control over lists
% \RequirePackage{xurl} % url hyphenation



%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%  FONTS  %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%

% By default academica changes font to a custom light font.
\ifacademica@defaultfont
\else
  % we first load light version of computer modern bright st
  % everything it's light, then we manyally override with 
  % fontspec the fonts, thus, only math or missing characters
  % are taken from cmbright
  \RequirePackage{cmbright}
  \RequirePackage{fontspec} % allow to specify custom font

  %------------------------------------------
  %--------------- Monospaced ---------------
  %------------------------------------------

  \setmonofont{MonofurNerdFontMono-}[
      % Path = fonts/,
      UprightFont = *Regular,
      ItalicFont = *Italic,
      BoldFont = *Bold,
      Extension = .ttf
  ]

  %----------------------------------------
  %--------------- Main font --------------
  %----------------------------------------

  \setmainfont{Outfit-}[
      UprightFont = *ExtraLight,
      ItalicFont = *ExtraLightItalic,
      BoldFont = *Medium,
      BoldItalicFont = *MediumItalic,
      Extension = .otf
  ]

  \setsansfont{Outfit-}[
      UprightFont = *ExtraLight,
      ItalicFont = *ExtraLightItalic,
      BoldFont = *Medium,
      BoldItalicFont = *MediumItalic,
      Extension = .otf
  ]
  
  \newfontface\semibold{Outfit-}[
      UprightFont = *Light,
      ItalicFont = *LightItalic,
      Extension = .otf
  ]

  %------------------------------------
  %--------------- Math ---------------
  %------------------------------------

  %\RequirePackage{unicode-math}

  %\setmathfont{OutfitMath}[
  %  Path = fonts/,
  %  Extension = {.otf}
  %]

\fi

\newcommand{\quoted}[1]{``{#1}''}
\newcommand{\textbi}[1]{\textbf{\textit{#1}}}
\newcommand{\textsb}[1]{{\semibold {#1}}}
\newcommand{\textsi}[1]{\textsb{\textit{#1}}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% COLORS %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\colorlet{graylight}{gray!50}
\colorlet{graymid}{gray!75}
\definecolor{graydark}{HTML}{525252}

\definecolor{lilla}{HTML}{B4B5EE}
\definecolor{blue}{HTML}{98CEF3}
\definecolor{deepsea}{HTML}{123499}
\definecolor{pink}{HTML}{F7ABDC}
\definecolor{red}{HTML}{E95678}
\colorlet{redlight}{red!60}
\definecolor{green}{HTML}{3FDAA4}
\definecolor{orange}{HTML}{F09483}
\definecolor{yellow}{HTML}{FAE3B0}

\colorlet{accent}{lilla!160}
\colorlet{accentlight}{lilla}
\colorlet{accentmedium}{lilla!240}
\colorlet{accentdark}{lilla!320}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% PAGING %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
\newcommand{\subsectiontitle}{}

% update stored chapter title whenever \chapter is used
\renewcommand{\chaptermark}[1]{
  \markboth{#1}{}
  \renewcommand{\chaptertitle}{#1}
  % reset section title when a new chapter starts
  \renewcommand{\sectiontitle}{}
  \renewcommand{\subsectiontitle}{}
}

% update stored section title whenever \section is used
\renewcommand{\sectionmark}[1]{
  \markright{#1}
  \renewcommand{\sectiontitle}{#1}
  \renewcommand{\subsectiontitle}{#1}
}

\renewcommand{\subsectionmark}[1]{
  \markright{#1}
  \renewcommand{\subsectiontitle}{#1}
}

% custom definition of header
\def\header{
  \ifnum\value{section}=0
    \MakeUppercase{\chaptertitle}
  \else
    \ifnum\value{subsection}=0
      \MakeUppercase{\chaptertitle} \ --- \ \textit{\sectiontitle}
    \else
      \MakeUppercase{\chaptertitle} \ --- \ \textit{\sectiontitle :\ \MakeLowercase{\subsectiontitle}}
    \fi
  \fi
}

\let\ps@plain\ps@empty%

% new page style `academica`
\@namedef{ps@academica}{
  \def\@evenhead{\thepage\hfill{\footnotesize \textcolor{accentdark}{\header}}}%
  \def\@oddhead{{\footnotesize \textcolor{accentdark}{\header}}\hfill\thepage}%
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% ENVIRONMENT %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% sets an empty circle as the second layer of itemize
\renewcommand{\labelitemii}{\circ}
\renewcommand{\labelitemiii}{-}

% sets the footnote marker inside tcolorbox (used by our custom enviroments like theorem)
% to a symbol instead of a letter
\renewcommand{\thempfootnote}{\fnsymbol{mpfootnote}}

\def\acknowledgements{\chapter*{\textcolor{accentmedium}{Acknowledgements}}}
\def\abstract{\chapter*{\textcolor{accentmedium}{Abstract}}\addcontentsline{toc}{chapter}{Abstract}}
\def\summary{\chapter{\textcolor{accentmedium}{Summary}}}

\newcommand{\keywords}[1]{%
  \par\bigskip
  \noindent\textbf{Keywords: }%
  \begingroup
    \def\and{, }%
    #1%
  \endgroup
  \par\smallskip
}

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

\tcbuselibrary{breakable,skins}
\newtcolorbox{accentbox}[4][]{
  breakable, %split the environment if the end of the page is reached
  enhanced,
  attach boxed title to top left={xshift=3mm,yshift=-3mm,yshifttext=-1mm},
  colback=#4!30,
  colframe=#4!160,
  colbacktitle=white,
  coltitle=#4!240,
  coltext=black,
  arc=4mm,boxrule=2pt,
  title={\textbf{#2 #3}\ifx#1\@empty\else : \emph{#1}\fi},
  boxed title style={size=small,colframe=#4!160,arc=2mm}
}
\newtcolorbox{accentbox*}[3][]{
  breakable, %split the environment if the end of the page is reached
  enhanced,
  attach boxed title to top left={xshift=3mm,yshift=-3mm,yshifttext=-1mm},
  colback=#3!30,
  colframe=#3!160,
  colbacktitle=white,
  coltitle=#3!240,
  coltext=black,
  arc=4mm,boxrule=2pt,
  title={\textbf{#2}\ifx#1\@empty\else : \emph{#1}\fi},
  boxed title style={size=small,colframe=#3!160,arc=2mm}
}

% definition of environment counters
\newcounter{definition}
\newcounter{theorem}
\newcounter{postulate}
\newcounter{lemma}
\newcounter{proposition}
\newcounter{corollary}
\newcounter{proof}
\newcounter{example}
\newcounter{exercise}
\newcounter{question}

% definition of \autoref name
\newcommand{\definitionautorefname}{Definition}
\renewcommand{\theoremautorefname}{Theorem}
\newcommand{\postulateautorefname}{Postulate}
\newcommand{\lemmaautorefname}{Lemma}
\newcommand{\propositionautorefname}{Proposition}
\newcommand{\corollaryautorefname}{Corollary}
\newcommand{\proofautorefname}{Proof}
\newcommand{\exampleautorefname}{Example}
\newcommand{\exerciseautorefname}{Exercise}
\newcommand{\questionautorefname}{Question}


% creation of colored enviroments
\newenvironment{definition}[1][]{\refstepcounter{definition}\def\@currentlabelname{#1}\begin{accentbox}[#1]{Definition}{\thedefinition}{lilla}}{\end{accentbox}}
\newenvironment{theorem}[1][]{\refstepcounter{theorem}\def\@currentlabelname{#1}\begin{accentbox}[#1]{Theorem}{\thetheorem}{blue}}{\end{accentbox}}
\newenvironment{postulate}[1][]{\refstepcounter{postulate}\def\@currentlabelname{#1}\begin{accentbox}[#1]{Postulate}{\thepostulate}{blue}}{\end{accentbox}}
\newenvironment{lemma}[1][]{\refstepcounter{lemma}\def\@currentlabelname{#1}\begin{accentbox}[#1]{Lemma}{\thelemma}{deepsea}}{\end{accentbox}}
\newenvironment{proposition}[1][]{\refstepcounter{proposition}\def\@currentlabelname{#1}\begin{accentbox}[#1]{Proposition}{\theproposition}{deepsea}}{\end{accentbox}}
\newenvironment{corollary}[1][]{\refstepcounter{corollary}\def\@currentlabelname{#1}\begin{accentbox}[#1]{Corollary}{\thecorollary}{deepsea}}{\end{accentbox}}
\newenvironment{proof}[1][]{\refstepcounter{proof}\def\@currentlabelname{#1}\begin{accentbox}[#1]{Proof}{\theproof}{pink}}{\end{accentbox}}
\newenvironment{example}[1][]{\refstepcounter{example}\def\@currentlabelname{#1}\begin{accentbox}[#1]{Example}{\theexample}{graylight}}{\end{accentbox}}
\newenvironment{exercise}[1][]{\refstepcounter{exercise}\def\@currentlabelname{#1}\begin{accentbox}[#1]{Exercise}{\theexercise}{graylight}}{\end{accentbox}}
\newenvironment{question}[1][]{\refstepcounter{question}\def\@currentlabelname{#1}\begin{accentbox}[#1]{Question}{\theexercise}{graylight}}{\end{accentbox}}

\newenvironment{definition*}[1][]{\begin{accentbox*}[#1]{Definition}{lilla}}{\end{accentbox*}}
\newenvironment{theorem*}[1][]{\begin{accentbox*}[#1]{Theorem}{blue}}{\end{accentbox*}}
\newenvironment{postulate*}[1][]{\begin{accentbox*}[#1]{Postulate}{blue}}{\end{accentbox*}}
\newenvironment{lemma*}[1][]{\begin{accentbox*}[#1]{Lemma}{deepsea}}{\end{accentbox*}}
\newenvironment{proposition*}[1][]{\begin{accentbox*}[#1]{Proposition}{deepsea}}{\end{accentbox*}}
\newenvironment{corollary*}[1][]{\begin{accentbox*}[#1]{Corollary}{deepsea}}{\end{accentbox*}}
\newenvironment{proof*}[1][]{\begin{accentbox*}[#1]{Proof}{pink}}{\end{accentbox*}}
\newenvironment{example*}[1][]{\begin{accentbox*}[#1]{Example}{graylight}}{\end{accentbox*}}
\newenvironment{exercise*}[1][]{\begin{accentbox*}[#1]{Exercise}{graylight}}{\end{accentbox*}}
\newenvironment{question*}[1][]{\begin{accentbox*}[#1]{Question}{graylight}}{\end{accentbox*}}
\newenvironment{remark}[1][]{\begin{accentbox*}[#1]{Remark}{redlight}}{\end{accentbox*}}
\newenvironment{note}[1][]{\begin{accentbox*}[#1]{Note}{redlight}}{\end{accentbox*}}

\newenvironment{displaybox}{\par\bigskip}{\par\bigskip}

% custom boxed part title
\titleformat{\part}[display]
  {\centering\Huge}
  {\bfseries\scshape\color{blue!160} Part \ \ \thepart}
  {2em}
  {\semibold\itshape}

% custom title body:
%     chaptertitle <empty> bigchapternumber
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

\renewcommand{\cleardoublepage}{
  \clearpage
  \if@twoside
    \ifodd\c@page
    \else
      \hbox{}\thispagestyle{empty}\newpage
    \fi
  \fi
}

\let\oldfrontmatter\frontmatter
\renewcommand{\frontmatter}{
  \pagestyle{empty}
  \oldfrontmatter
}

\let\oldmainmatter\mainmatter
\renewcommand{\mainmatter}{
  \pagestyle{academica}
  \oldmainmatter
  \setcounter{page}{1}
  \academicachaptermain
}

\let\oldbackmatter\backmatter
\renewcommand{\backmatter}{
  \pagestyle{empty}
  \oldbackmatter
  \academicachapterback
}

% options for listings
\lstset{
  language=Python,
  basicstyle=\linespread{0.8}\ttfamily,
  keywordstyle=\color{accent!125}\bfseries,
  commentstyle=\color{gray!70}\itshape,
  showstringspaces=false,
  mathescape=true
}

% gray math in listing comments
\newcommand{\gm}[1]{{\color{gray!75}{#1}}}



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
    \vfill
  \else
    \@for\@ban:=\academica@banner\do{\includegraphics[width=\textwidth]{banners/\@ban.pdf}\\}
    \vskip 5em\@plus1fill\relax
  \fi
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
\deffields{overtitle,subtitle,supervisor,cosupervisor,tutor,institutecontacts,authorcontacts,rights}

% Field names
\def\authorname{Author}
\def\supervisorname{Supervisor}
\def\cosupervisorname{Co-Supervisor}
\def\tutorname{Tutor}
\def\institutecontactsname{Institute Contacts}
\def\authorcontactsname{Author Contacts}

\gdef\uniudcontacts{
	Universit\`a degli Studi di Udine: Dipartimento di Scienze Matematiche, Informatiche e Fisiche\\
	Via delle Scienze, 206, 33100 Udine (IT)\\
	+39 0432 558400\\
  \href{mailto:info.dmif@uniud.it}{info.dmif@uniud.it}\\
	\@ifundefined{url}\texttt\url{https://www.dmif.uniud.it/}
}

\gdef\commonrights{
	\textcopyright\ \the\year\ \@author\\ This work is shared under the Creative Commons 4.0 License Attribution-NonCommercial-ShareAlike.
}

\def\maketitle{
  %\newgeometry{centering}
  \newgeometry{
    top=2cm,
    bottom=2cm,
    left=2.5cm,
    right=2.5cm
  }
    \begin{titlepage}
      \noindent
      \begin{minipage}[t][\textheight][s]{\linewidth}
        \begin{center}
          {\@banner}
          {\textcolor{accentdark}{\textsc{\large \@overtitle}}\par}
          \vskip 2em\@plus1fill\relax
          {\fontsize{30}{20}\selectfont\bfseries\@title\par}
          \vskip 3em\relax
          {\Large\textsi{\@subtitle}\par}
          \vskip 5em\@plus1fill\relax
          {\large
            \if\@supervisor\@empty
              \shows{author}
            \else
              \parbox[t]{0.46\linewidth}{
                \raggedright
                \shows{author}
              }
              \qquad
              \parbox[t]{0.46\linewidth}{
                \raggedleft
                \shows{supervisor}
                \shows{cosupervisor}
                \shows{tutor}
              }
            \fi
          }
          \par\vskip 2em\@plus1fill\relax
          {\large\@date}\par
        \end{center}
      \end{minipage}
    \end{titlepage}
  \restoregeometry
  {
    \parindent\z@\relax
    \show{institutecontacts}
    \show{authorcontacts}
    \vfill
    \show{rights}
  }
  \rmfamily
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%   TOC   %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\contentsmargin{0cm}

% Compute fixed chapter box width once (measure widest case: "Chapter 20")
% Store in \acadChapBoxWd for reuse
\newlength{\acadChapBoxWd}
\newlength{\acadChapBoxInnWd}
\AtBeginDocument{%
  \sbox0{\Large\scshape\bfseries Chapter\ 20}%
  \setlength{\acadChapBoxInnWd}{\wd0}%
  % total box width = inner text + 2×horizontal padding (0.20cm each side)
  \setlength{\acadChapBoxWd}{\acadChapBoxInnWd}%
  \addtolength{\acadChapBoxWd}{0.40cm} % 2 × 0.20cm padding
}
\newlength{\tocChapRightEdge}
\setlength{\tocChapRightEdge}{-0.20cm}

% edit appearance of `part` inside toc
\titlecontents{part}[-1pc]
{
  \addvspace{50pt}
  \begin{tikzpicture}[overlay]
    \draw[fill=blue,draw=blue,rounded corners] (-4.5,-0.2) rectangle (0.45,0.58);
    \pgftext[left,x=-1.6cm,y=0.2cm]{\Large\scshape\bfseries Part}
  \end{tikzpicture}\large\scshape\bfseries
}
{}
{}
{}

% edit appearance of `chapter` inside toc
\titlecontents{chapter}[5pc]
{
  \addvspace{30pt}
  \begin{tikzpicture}[overlay]
    \pgfmathsetmacro{\tocBoxW}{\the\acadChapBoxWd/28.3465}%
    \pgfmathsetmacro{\tocRcm}{\the\tocChapRightEdge/28.3465}%
    \draw[fill=accent,draw=accent,rounded corners]
      (\tocRcm cm - \tocBoxW cm, -0.2) rectangle (\tocRcm cm, 0.58);
    \pgftext[left, x=\tocRcm cm - \tocBoxW cm + 0.20cm, y=0.2cm]{%
      \textcolor{white}{%
        \makebox[\acadChapBoxInnWd][l]{%
          \Large\scshape\bfseries Chapter%
          \ifx\thecontentslabel\@empty
            \hfill
          \else
            \hfill\thecontentslabel
          \fi
        }%
      }%
    }
  \end{tikzpicture}\large\scshape\bfseries
}
{}
{}
{
  \;\titlerule\;\large\scshape\bfseries Page \thecontentspage
  \begin{tikzpicture}[overlay]
    \draw[fill=black,draw=black] (4pt,0.2pt) rectangle (4cm,0.2pt);
  \end{tikzpicture}
}

%-----------------------------------------------------------------
%-----------------------------------------------------------------

%% pt→cm conversion: 1cm = 28.3465pt
%\newlength{\acadtocwd}
%
%% edit appearance of `part` inside toc
%\titlecontents{part}[-1pc]
%{
%  \addvspace{50pt}
%  \sbox0{\Large\scshape\bfseries Part}%
%  \setlength{\acadtocwd}{\wd0}%
%  \pgfmathsetmacro{\tocboxR}{-0.3}%            % fixed right edge (cm)
%  \pgfmathsetmacro{\tocboxPad}{0.14}%           % horizontal padding (cm)
%  \pgfmathsetmacro{\tocboxTW}{\the\acadtocwd/28.3465}%
%  \pgfmathsetmacro{\tocboxL}{\tocboxR - \tocboxTW - 2*\tocboxPad}%
%  \begin{tikzpicture}[overlay]
%    \draw[fill=accent,draw=accent,rounded corners]
%      (\tocboxL cm,-0.2) rectangle (\tocboxR cm,0.55);
%    \pgftext[right,x=\tocboxR cm - \tocboxPad cm,y=0.18cm]{%
%      \textcolor{white}{\Large\scshape\bfseries Part}}
%  \end{tikzpicture}\large\scshape\bfseries
%}
%{}
%{}
%{}
%
%% edit appearance of `chapter` inside toc
%\titlecontents{chapter}[5pc]
%{
%  \addvspace{30pt}
%  % measure whatever goes in the box — handles "", "1", "12" uniformly
%  \ifx\thecontentslabel\@empty
%    \sbox0{\Large\scshape\bfseries Chapter}%
%  \else
%    \sbox0{\Large\scshape\bfseries Chapter\ \thecontentslabel}%
%  \fi
%  \setlength{\acadtocwd}{\wd0}%
%  \pgfmathsetmacro{\tocboxR}{-0.3}%            % right edge: fixed, digits land here
%  \pgfmathsetmacro{\tocboxPad}{0.14}%           % padding left+right of text
%  \pgfmathsetmacro{\tocboxTW}{\the\acadtocwd/28.3465}%
%  \pgfmathsetmacro{\tocboxL}{\tocboxR - \tocboxTW - 2*\tocboxPad}%
%  \begin{tikzpicture}[overlay]
%    \draw[fill=accent,draw=accent,rounded corners]
%      (\tocboxL cm,-0.2) rectangle (\tocboxR cm,0.55);
%    \pgftext[right,x=\tocboxR cm - \tocboxPad cm,y=0.18cm]{%
%      \textcolor{white}{\Large\scshape\bfseries
%        \ifx\thecontentslabel\@empty Chapter\else Chapter\ \thecontentslabel\fi}}
%  \end{tikzpicture}\large\scshape\bfseries
%}
%{}
%{}
%{
%  \;\titlerule\;\large\scshape\bfseries Page \thecontentspage
%  \begin{tikzpicture}[overlay]
%    \draw[fill=black,draw=black] (4pt,0.2pt) rectangle (4cm,0.2pt);
%  \end{tikzpicture}
%}

%-----------------------------------------------------------------
%-----------------------------------------------------------------

%% edit appereance of `part` inside toc
%\titlecontents{part}[-1pc]
%{
%  \addvspace{50pt}
%	\begin{tikzpicture}[overlay]
%		\draw[fill=accent,draw=accent,rounded corners] (-4.5,-0.2) rectangle (-0.2,0.55);
%    \pgftext[left,x=-1.6cm,y=0.15cm]{\textcolor{white}{\Large\scshape\bfseries Part}}
%	\end{tikzpicture}\large\scshape\bfseries
%}
%{}
%{}
%{}
%
%% edit appereance of `chapter` inside toc
%\titlecontents{chapter}[5pc]
%{
%  \addvspace{30pt}
%  \ifx\thecontentslabel\@empty
%    \begin{tikzpicture}[overlay]
%	  	\draw[fill=accent,draw=accent,rounded corners] (-3.5,-0.2) rectangle (-0.7,0.55);
%      \pgftext[left,x=-3.38cm,y=0.18cm]{\textcolor{white}{\Large\scshape\bfseries Chapter}}
%    \end{tikzpicture}\large\scshape\bfseries
%  \else
%	  \begin{tikzpicture}[overlay]
%	  	\draw[fill=accent,draw=accent,rounded corners] (-3.5,-0.2) rectangle (-0.3,0.55);
%      \pgftext[left,x=-3.42cm,y=0.18cm]{\textcolor{white}{\Large\scshape\bfseries Chapter\ \thecontentslabel}}
%    \end{tikzpicture}\large\scshape\bfseries
%  \fi
%}
%{}
%{}
%{
%  \;\titlerule\;\large\scshape\bfseries Page \thecontentspage
%	\begin{tikzpicture}[overlay]
%		\draw[fill=black,draw=black] (4pt,0.2pt) rectangle (4cm,0.2pt);
%	\end{tikzpicture}
%}

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
{\scriptsize$\circ$\quad\small}
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
	\chapter*{
	  \vspace*{-20\p@}
	  \begin{tikzpicture}[overlay]
		  \draw[fill=accent,draw=accent,rounded corners] (10,-0.65) rectangle (20,1);
      \pgftext[right,x=16.7cm,y=0.2cm]{\Huge\scshape\bfseries\textcolor{white}{List of Figures}}
	  \end{tikzpicture}
  }
  \@starttoc{lof}
}

\renewcommand{\listoftables}{
	\chapter*{
	  \vspace*{-20\p@}
	  \begin{tikzpicture}[overlay]
		  \draw[fill=accent,draw=accent,rounded corners] (10.5,-0.65) rectangle (20,1);
      \pgftext[right,x=16.7cm,y=0.2cm]{\Huge\scshape\bfseries\textcolor{white}{List of Tables}}
	  \end{tikzpicture}
  }
  \@starttoc{lot}
}

% move contents title on the right then prints TOC with figures and tables
\renewcommand{\tableofcontents}{
	\chapter*{
	  \vspace*{-20\p@}
	  \begin{tikzpicture}[overlay]
		  \draw[fill=accent,draw=accent,rounded corners] (12.2,-0.65) rectangle (20,1);
      \pgftext[right,x=16.7cm,y=0.2cm]{\Huge\scshape\bfseries\textcolor{white}{\contentsname}}
	  \end{tikzpicture}
  }
	\@starttoc{toc}
  \iftotalfigures\listoffigures\fi
  \iftotaltables\listoftables\fi
  \clearpage
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%   REFERENCES   %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% set bib resource in preamble.tex with
% \addbibresource{bib/main.bib}

\DeclareFieldFormat{title}{\mkbibquote{#1}} % applies quotes to title in all entry types (@Misc, was missing them)

\def\references{
  \chapter*{\textcolor{accentmedium}{Bibliography}}\addcontentsline{toc}{chapter}{Bibliography}
  % \nocite{*} % adds all bibliography entries, even not cited
  \printbibliography[heading=none]
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%   HYPHENATION   %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\hyphenation{
  sto-res
  sha-red
  ta-bleau
  ta-bleaux
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%   COMMON COMMANDS   %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\ie}{\textit{i.e.}}
\newcommand{\eg}{\textit{e.g.}}
\newcommand{\st}{\textit{s.t.} }

\newcommand{\wlogt}{w.l.o.g.\xspace}
\newcommand{\Wlogt}{W.l.o.g.\xspace}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%   MATH COMMANDS   %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\abs}[1]{\left\vert {#1} \right\vert}
\newcommand{\norm}[1]{\lVert {#1} \rVert}
\newcommand{\vars}[3]{{#1}_{#2},\ldots,{#1}_{#3}}

\newcommand{\ifft}{\text{ iff }}
\newcommand{\ift}{\text{if }}
\newcommand{\andt}{\text{ and }}
\newcommand{\ort}{\text{ or }}
\newcommand{\fort}{\text{ for }}

\newcommand{\tuple}[1]{(\,#1\,)}
\newcommand{\tuplev}[1]{\langle\,#1\,\rangle}
\newcommand{\set}[1]{\{\,#1\,\}}

\newcommand{\bigtuple}[1]{\big(\,#1\,\big)}
\newcommand{\Bigtuple}[1]{\Big(\,#1\,\Big)}
\newcommand{\bigset}[1]{\big\{\,#1\,\big\}}
\newcommand{\Bigset}[1]{\Big\{\,#1\,\Big\}}

\renewcommand{\a}{\alpha}
\renewcommand{\b}{\beta}
\renewcommand{\d}{\delta}
\newcommand{\e}{\varepsilon}
\newcommand{\s}{\sigma}
\newcommand{\p}{\varphi}
\renewcommand{\t}{\tau}
\renewcommand{\u}{\mu}
\newcommand{\w}{\omega}
\newcommand{\y}{\gamma}
\newcommand{\D}{\Delta}
\renewcommand{\S}{\Sigma}
\renewcommand{\O}{\Omega}

\newcommand{\A}{\mathcal{A}}
\newcommand{\B}{\mathcal{B}}
\newcommand{\C}{\mathcal{C}}
\newcommand{\F}{\mathcal{F}}
\newcommand{\G}{\mathcal{G}}
\newcommand{\J}{\mathcal{J}}
\renewcommand{\L}{\mathcal{L}}
\renewcommand{\P}{\mathcal{P}}
\newcommand{\T}{\mathcal{T}}
\newcommand{\V}{\mathcal{V}}

\newcommand{\CC}{\mathbb{C}}
\newcommand{\NN}{\mathbb{N}}
\newcommand{\RR}{\mathbb{R}}
\newcommand{\QQ}{\mathbb{Q}}

\newcommand{\true}{\textsc{true}\xspace}
\newcommand{\false}{\textsc{false}\xspace}

\DeclareMathOperator{\xor}{\oplus}
\renewcommand{\emptyset}{\varnothing}
\renewcommand{\min}{\text{min}}
\renewcommand{\max}{\text{max}}
% \renewcommand{\mod}{\text{ mod }}

% Default math commands useful for spacing:
% \; - a thick space
% \: - a medium space
% \, - a thin space
% \! - a negative thin space
