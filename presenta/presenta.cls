\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{presenta}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% BASIC CLASS OPTIONS %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Basic options without parameters
\newif\ifpresenta@pdfa
\DeclareOption{pdfa}{\presenta@pdfatrue}
\DeclareOption{handout}{\PassOptionsToClass{handout}{beamer}}
\newif\ifpresenta@defaultfont
\DeclareOption{defaultfont}{\presenta@defaultfonttrue}
\ProcessOptions\relax


\LoadClass[aspectratio=169,xcolor=table]{beamer}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% PARAMETERED CLASS OPTIONS %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{kvoptions} % allows passing arguments to class options
\SetupKeyvalOptions{prefix={presenta@}}
\DeclareStringOption[]{banner}[]
\ProcessKeyvalOptions{presenta}\relax



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% PACKAGES %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Sets if the generated output should be a `pdfa`
\ifpresenta@pdfa
  \RequirePackage[a-1b]{pdfx} % generates pdfa output
  \RequirePackage[pdfa]{hyperref}
\else
  \RequirePackage{hyperref} % management of hyperlinks, plus autogeneration of bookmarks
\fi

%\RequirePackage{geometry} % sets page geometry style
%\RequirePackage{titlesec} % easily modify appereance of chapters and sections
%\RequirePackage{titletoc} % easily modify appereance of tableofcontents

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
\usetikzlibrary{overlay-beamer-styles} % adds beamer options
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
\RequirePackage{ragged2e} % provides justification inside columns
% \RequirePackage{array} % other tabular improvements like custom widths

\RequirePackage[figure,table]{totalcount} % get total occurences of figures and tables (used in TOC)

\RequirePackage{cancel} % for cancelling our math
\RequirePackage{listings} % for block of codes
\RequirePackage{adjustbox} % automatically adjust width of figure/tikz
\RequirePackage{xspace} % for space only if no punctuation follows
\RequirePackage{enumitem} % improved control over lists
% \RequirePackage{xurl} % url hyphenation


%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%  FONTS  %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%

% By default sets text to a light font.
\ifpresenta@defaultfont
\else
  %\RequirePackage{unicode-math}
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

\setbeamerfont{caption name}{series=\bfseries}



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

\setlist[enumerate]{label={\ifnum\@itemdepth=1\relax
  \color{accent}\else
  \color{accentmedium}\fi\textbf{\theenumi.}}}

\setlist[itemize]{label=\color{accent}$\bullet$}

\setbeamercolor{caption name}{fg=accent}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% BACKGOUND PATTERNS %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\setbeamertemplate{background}{
  \begin{tikzpicture}
    \useasboundingbox (0,0) rectangle(\paperwidth,\paperheight);
    \fill[accentlight] (0,0) rectangle (\paperwidth,\paperheight);
    \def \x {7pt}
    \def \y {6pt}
    \fill[white, rounded corners=0.4cm] (\x,\y) rectangle (\paperwidth-\x,\paperheight-\y);
  \end{tikzpicture}
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%  TITLE  %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\deffield}[1]{
  \expandafter\newcommand\csname @#1\endcsname{}
  \expandafter\newcommand\csname #1\endcsname[1]{
    \expandafter\gdef\csname @#1\endcsname{##1}
  }
}

\newcommand{\deffields}[1]{
  \@for\@field:=#1\do{
    \expandafter\deffield\expandafter{\@field}
  }
}

\def\show#1{
  \if\csname @#1\endcsname\@empty
  \else
    \textcolor{accentdark}{\textsc{\csname #1name\endcsname}}\\
    \textit{\csname @#1\endcsname}\par
    \vskip0.2cm\relax
  \fi
}

\newcount\@numitems

\newcommand{\countitems}[1]{
  \@numitems\z@
  \expandafter\@for\expandafter\@item\expandafter:\expandafter=\csname @#1\endcsname\do{\advance\@numitems\@ne}
}

\def\shows#1{
  \if\csname @#1\endcsname\@empty
  \else
    \countitems{#1}
    \ifnum\the\@numitems>1
      \textcolor{accent}{\textsc{\csname #1name\endcsname s}}\\
    \else
      \textcolor{accent}{\textsc{\csname #1name\endcsname}}\\
    \fi
    \expandafter\@for\expandafter\entry\expandafter:\expandafter=\csname @#1\endcsname\do{
      \textit{\entry}\par
    }
    \vskip0.1cm\relax
  \fi
}

\def\supervisorname{Supervisor}
\def\cosupervisorname{Co-Supervisor}
\def\tutorname{Tutor}

\deffields{supervisor,cosupervisor,tutor}

\def\@banner{
  \begin{center}
    \vspace{-10pt}\@for\@ban:=\presenta@banner\do{\hspace{20pt}\includegraphics[width=0.6\textwidth]{banners/\@ban.pdf}\\}
  \end{center}
}

\defbeamertemplate*{title page}{}[1][]
{ 
  \ifx\presenta@banner\@empty
    \vskip1.2cm
  \else
    \@banner
  \fi
  \vfill
  \setbeamercolor{title page header}{fg=accent,bg=white}
  \begin{beamercolorbox}[wd=8cm,rounded=true,leftskip=0cm,sep=8pt,#1]{title page header}
      \raggedright\LARGE\bfseries\inserttitle\par
      \raggedright\large\textsi{\insertsubtitle}\par
  \end{beamercolorbox}%
  \vskip0.4cm%
  \small
  \begin{columns}
    \begin{column}[b]{0.40\paperwidth}
      \raggedright
      \textcolor{accentmedium}{\textsc{Author}}\\
      \textit{\insertauthor}
      \vskip0.4cm%
      \insertdate
    \end{column}
    \hfill
    \begin{column}[b]{0.35\paperwidth}
      \raggedleft
      \shows{supervisor}
      \shows{cosupervisor}
      \shows{tutor}
    \end{column}
  \end{columns}
}

\let\oldmaketitle\maketitle
\renewcommand\maketitle{
  {
    \setcounter{page}{-1}
    \setbeamertemplate{footline}{}
    \oldmaketitle
  }
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% SECTION %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\AtBeginSection[]{
  {
    \addtocounter{framenumber}{-1}
    \setbeamertemplate{footline}{}
    \settowidth{\@tempdima}{\huge\insertsectionhead}
    \begin{frame}
      \begin{center}
        \vspace{1cm}
        \tikz[baseline]{
              \draw[fill=accent,draw=accent,rounded corners] (-\@tempdima/2-60pt,-.6) rectangle (\@tempdima/2 + 60pt,.6) node [midway]{\color{white}\huge\sc\bfseries \insertsectionhead};
        }
      \end{center}
    \end{frame}
  }
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% FRAME TITLE %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\defbeamertemplate*{frametitle}{left}[1][]
{
  \begin{beamercolorbox}[wd=\paperwidth,ht=1.2cm]{frametitle}
    \settowidth{\@tempdima}{\Large\insertframetitle}
    \settowidth{\@tempdimb}{\large\ \ \insertframesubtitle}
    \ifx\insertframesubtitle\@empty
      \begin{tikzpicture}[remember picture, overlay]
        \draw[fill=accent,draw=accent] (-0.55pt,0) rectangle (0.5,0.6);
        \draw[fill=accent,draw=accent,rounded corners] (0,0) rectangle (\@tempdima+20pt,0.6) node [midway]{\color{white}\Large\bfseries \insertframetitle};
      \end{tikzpicture}
    \else
      \begin{tikzpicture}[remember picture, overlay]
        \draw[fill=accent,draw=accent] (-0.55pt,0) rectangle (0.5,0.6);
        \draw[draw=accent,rounded corners] (\@tempdima+10pt,0) rectangle (\@tempdima+\@tempdimb+30pt,0.6) node [midway] {\color{accent}\large\textsi{\ \ \insertframesubtitle}};
        \draw[fill=accent,draw=accent,rounded corners] (0,0) rectangle (\@tempdima+20pt,0.6) node [midway]{\color{white}\Large\bfseries \insertframetitle};
      \end{tikzpicture}
    \fi
  \end{beamercolorbox}
}

\defbeamertemplate{frametitle}{right}[1][]
{
  \begin{beamercolorbox}[wd=\paperwidth,ht=1.2cm]{frametitle}
    \settowidth{\@tempdima}{\Large\insertframetitle}
    \settowidth{\@tempdimb}{\large\insertframesubtitle\ \ \ }
    \ifx\insertframesubtitle\@empty
      \begin{tikzpicture}[remember picture, overlay]
      \draw[fill=accent,draw=accent] (\paperwidth-20pt,0.6) rectangle (\paperwidth-14.9pt,0);
      \draw[fill=accent,draw=accent,rounded corners] (\paperwidth-\@tempdima-40pt,0.6) rectangle (\paperwidth-15pt,0) node [midway]{\color{white}\Large\bfseries \insertframetitle};
      \end{tikzpicture}
    \else
      \begin{tikzpicture}[remember picture, overlay]
      \draw[fill=accent,draw=accent] (\paperwidth-20pt,0.6) rectangle (\paperwidth - 14.9pt,0);
      \draw[draw=accent,rounded corners] (\paperwidth-\@tempdima-\@tempdimb-48pt,0.6) rectangle (\paperwidth-\@tempdima-33pt,0) node [midway] {\color{accent}\large\textsi{\insertframesubtitle \ \ \ }};
      \draw[fill=accent,draw=accent,rounded corners] (\paperwidth-\@tempdima-40pt,0.6) rectangle (\paperwidth-15pt,0) node [midway]{\color{white}\Large\bfseries \insertframetitle};
      \end{tikzpicture}
    \fi
  \end{beamercolorbox}
}

\BeforeBeginEnvironment{frame}{
  \setbeamertemplate{frametitle}[left]
  \addtolength{\textheight}{-0.3pt}
}

\define@key{beamerframe}{right}[true]{
  \setbeamertemplate{frametitle}[right]
  \addtolength{\textheight}{-0.3pt}
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% STANDOUT %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\standout}[1]{
  {
    \addtocounter{framenumber}{-1}
    \setbeamertemplate{footline}{}
    \begin{frame}
      \begin{center}
        \vspace{1cm}
        \color{accent}\Large\bfseries \texttt{#1}
      \end{center}
    \end{frame}
  }
}



%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%  TOC  %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%

\setbeamertemplate{section in toc}{
  {\Huge \textcolor{accent}{\textbf{\texttt{\inserttocsectionnumber}}}}
  \hskip1.5ex
  {\Large\bfseries \textcolor{black!90}{\inserttocsection}}
}

\let\oldtableofcontents\tableofcontents
\renewcommand\tableofcontents{
  {
    \addtocounter{framenumber}{-1}
    \setbeamertemplate{footline}{}
    \begin{frame}
    	\begin{tikzpicture}[remember picture, overlay]
    	  \draw[fill=accent,draw=accent,rounded corners] (10,0.4) rectangle (11,-0.6);
    	  \draw[fill=accent,draw=accent] (10.5,0.4) rectangle (14.75,-0.6);
    	  \pgftext[left,x=10.5cm,y=-0.1cm]{\color{white}\huge\sc\bfseries \contentsname};
    	\end{tikzpicture}
    
      \bigskip
      \oldtableofcontents
    \end{frame}
  }
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% ENVIRONMENT %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\setbeamertemplate{frametitle continuation}{} % doesn't add numbers in title of frame continuations
\setbeamertemplate{navigation symbols}{} % remove navigation symbols
\setbeamertemplate{headline}{} % remove headline
%\setbeamercovered{invisible} % add \invisible command to render part only on specific moments
%\setbeamertemplate{blocks}[rounded][shadow=false]

\tcbuselibrary{skins}
\newtcolorbox{accentbox}[3][]{
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
\newtcolorbox{accentbox*}[3][]{
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

\renewenvironment{definition}[1][]{\begin{accentbox}[#1]{Definition}{lilla}}{\end{accentbox}}
\renewenvironment{theorem}[1][]{\begin{accentbox}[#1]{Theorem}{blue}}{\end{accentbox}}
\newenvironment{postulate}[1][]{\begin{accentbox}[#1]{Postulate}{blue}}{\end{accentbox}}
\renewenvironment{lemma}[1][]{\begin{accentbox}[#1]{Lemma}{deepsea}}{\end{accentbox}}
\newenvironment{proposition}[1][]{\begin{accentbox}[#1]{Proposition}{deepsea}}{\end{accentbox}}
\renewenvironment{corollary}[1][]{\begin{accentbox}[#1]{Corollary}{deepsea}}{\end{accentbox}}
\renewenvironment{proof}[1][]{\begin{accentbox}[#1]{Proof}{pink}}{\end{accentbox}}
\renewenvironment{example}[1][]{\begin{accentbox}[#1]{Example}{graylight}}{\end{accentbox}}
\newenvironment{exercise}[1][]{\begin{accentbox}[#1]{Exercise}{graylight}}{\end{accentbox}}
\newenvironment{question}[1][]{\begin{accentbox}[#1]{Question}{graylight}}{\end{accentbox}}

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
\renewenvironment{note}[1][]{\begin{accentbox*}[#1]{Note}{redlight}}{\end{accentbox*}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%  FOOT PAGE  %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\setbeamertemplate{footline}{
  \begin{beamercolorbox}[wd=\paperwidth,ht=-.5ex,dp=1.125ex,right]{page number in head/foot}
    \textcolor{graydark}{\the\numexpr\insertframenumber-1\relax/\the\numexpr\inserttotalframenumber-1\relax}
    \hspace{12pt}
    \vspace{4pt}
  \end{beamercolorbox}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%  CODING %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
%%%%%%%   REFERENCES   %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% set bib resource in preamble.tex with
% \addbibresource{bib/main.bib}

\DeclareFieldFormat{title}{\mkbibquote{#1}} % applies quotes to title in all entry types (@Misc, was missing them)

\def\references{
  {
    \addtocounter{framenumber}{-1}
    \setbeamertemplate{footline}{}
    \begin{frame}[allowframebreaks,right]{\textsc{References}}
      \nocite{*}
      \printbibliography[heading=none]
    \end{frame}
  }
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
