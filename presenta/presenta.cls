\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{presenta}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% BASIC CLASS OPTIONS %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Basic options without parameters
\newif\ifpresenta@pdfa
\DeclareOption{pdfa}{\presenta@pdfatrue} % class option pdfa
\DeclareOption{handout}{\PassOptionsToClass{handout}{beamer}} 
\newif\ifpresenta@nolight
\DeclareOption{nolight}{\presenta@nolighttrue} % class option light
\ProcessOptions\relax

%\RequirePackage[table]{xcolor} % color managements % already loaded in beamer, thus cannot reload with table
\LoadClass[aspectratio=169,xcolor=table]{beamer}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% PARAMETERED CLASS OPTIONS %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% More complex options that allow passing strings
\RequirePackage{kvoptions} % allows passing arguments to class options
\SetupKeyvalOptions{prefix={presenta@}}
\DeclareStringOption[]{banner}[] % class option banner
\ProcessKeyvalOptions{presenta}\relax




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% PACKAGES %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Sets if the generated output should be a `pdfa`
\ifpresenta@pdfa
  \RequirePackage[a-1b]{pdfx} % generates pdfa output
  \RequirePackage[pdfa]{hyperref} % management of hyperlinks, plus autogeneration of bookmarks
\else
  \RequirePackage{hyperref} % management of hyperlinks, plus autogeneration of bookmarks
\fi

\RequirePackage{graphicx} % allow use of \includegraphics
\RequirePackage{float} % floating positioning for images, ..
\RequirePackage{caption} % provide captions (images, tables, ..)
\RequirePackage{subcaption} % provides subfigures and subcaptions

\RequirePackage[backend=biber,style=numeric,maxbibnames=99,doi=true,eprint=true,sorting=none]{biblatex} % bibliography management

\RequirePackage{tcolorbox} % creation of colored boxes

\RequirePackage{mathtools,amssymb} % math environments (equation, ..) and math symbols
\RequirePackage{tikz} % creation of tikz pictures
\usetikzlibrary{shadows,overlay-beamer-styles} % adds shadow and beamer options into tikz pictures
\RequirePackage{pgfplots} % extend tikz by adding plots
\pgfplotsset{compat=1.18} % sets pgfplots compat version

\RequirePackage{tabularx} % powerful tabular
\RequirePackage{ragged2e} % provides justification inside columns
\RequirePackage{enumitem} % itemize customization

%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%  FONTS  %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%

% Sets text to a light font.
% We firstly load `cmbright` that sets both text and math, to have a light math, matching the SopiaPro style.
% Then we overwrite the text font with SofiaPro.
\ifpresenta@nolight
\else
  % Set font to use Computer Modern Bright (works also with pdfLatex)
  \RequirePackage{cmbright} % light version of Computer Modern (default LaTex font)

  % Set font to use SofiaPro (need LuaLatex/XeLatex engine)
  \RequirePackage{fontspec} % allow to specify custom font

  % Sets mono font i.e. typewriter
  %\setmonofont[
  %    Path = fonts/Comfortaa/,
  %    UprightFont = *Regular,
  %    BoldFont = *Bold,
  %    Extension = .ttf
  %]{Comfortaa-}

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
      UprightFont = *ExtraLight.otf,
      SlantedFont = *ExtraLight-Italic.otf,
      ItalicFont = *ExtraLight-Italic.otf,
      %ItalicFont = FlorentiaExtraLight-Italic.ttf,
      BoldFont = *Medium.otf, BoldItalicFont = *Medium-Italic.otf,
  ]{SofiaPro}
  
  % Sets roman font i.e. default text font (called upright)
  \setmainfont[
      Path = fonts/SofiaPro/,
      UprightFont = *ExtraLight.otf,
      SlantedFont = *ExtraLight-Italic.otf,
      ItalicFont = FlorentiaExtraLight-Italic.ttf,
      BoldFont = *Medium.otf,
      BoldItalicFont = *Medium-Italic.otf,
  ]{SofiaPro}

  \newfontfamily\semiboldfont[
      Path = fonts/SofiaPro/,
      UprightFont = *Light,
      ItalicFont = *Light-Italic,
      Extension = .otf
  ]{SofiaPro}

  \newfontfamily\semiboldfontitalic[
      Path = fonts/SofiaPro/,
      UprightFont = *Light-Italic,
      Extension = .otf
  ]{SofiaPro}

  %\setbeamerfont{subtitle}{family=\semiboldfontitalic}
\fi

%\setbeamerfont{title}{series=\bfseries, size=\LARGE}
%\setbeamerfont{author}{shape=\itshape}
%\setbeamerfont{frametitle}{series=\bfseries, size=\Large}
%\setbeamerfont{section}{series=\bfseries, size=\Large}
%\setbeamerfont{section in toc}{series=\bfseries}
\setbeamerfont{caption name}{series=\bfseries}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% COLORS %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%\definecolor{white}{HTML}{F5F5F5}
\definecolor{black}{HTML}{1D1D1C}
\definecolor{graydark}{HTML}{525252}

\definecolor{lilla}{HTML}{B4B5EE}
\definecolor{blue}{HTML}{98CEF3}
\definecolor{deepsea}{HTML}{123499}
\definecolor{pink}{HTML}{F7ABDC}
\definecolor{red}{HTML}{E95678}
\definecolor{green}{HTML}{3FDAA4}
\definecolor{orange}{HTML}{F09483}

\colorlet{accent}{lilla!160}
\colorlet{accentlight}{lilla}
\colorlet{accentmedium}{lilla!240}
\colorlet{accentdark}{lilla!320}

%\setbeamercolor*{title page header}{fg=white}
%\setbeamercolor*{subtitle page header}{fg=white}
%\setbeamercolor*{author}{fg=white}
%\setbeamercolor*{date}{fg=white}
%\setbeamercolor{background canvas}{bg=white}

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
      \useasboundingbox (0,0) rectangle(\the\paperwidth,\the\paperheight);
      \fill[accentlight] (0,0) rectangle (\paperwidth,\paperheight);
      \def \x {7pt}
      \def \y {6pt}
      %\fill[white, rounded corners=0.4cm,drop shadow={white, shadow scale=1.006, shadow xshift=1pt, shadow yshift=-1pt}] (\x,\x) rectangle (\paperwidth-\x,\paperheight-\x);
      \fill[white, rounded corners=0.4cm] (\x,\y) rectangle (\paperwidth-\x,\paperheight-\y);
  \end{tikzpicture}
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%  TITLE  %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
    \vskip0.2cm\relax
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

\deffields{overtitle,supervisor,cosupervisor,tutor}

\def\@banner{
  \begin{center}
    \vspace{-10pt}\@for\@ban:=\presenta@banner\do{\hspace{20pt}\includegraphics[width=0.6\textwidth]{banners/\@ban.pdf}\\}
  \end{center}
}



%\setbeamerfont{subtitle}{family=\semiboldfontitalic}
%\setbeamerfont{title}{series=\bfseries, size=\LARGE}
%\setbeamerfont{author}{shape=\itshape}
%\setbeamerfont{frametitle}{series=\bfseries, size=\Large}
%\setbeamerfont{section}{series=\bfseries, size=\Large}

\defbeamertemplate*{title page}{}[1][]
{ 
  \setbeamertemplate{headline}{} 
  \setbeamertemplate{footline}{}
  \setbeamertemplate{navigation symbols}{}   
  \ifx\presenta@banner\@empty
    \vskip1.2cm
  \else
    \@banner
  \fi
  \vfill

  %\setbeamercolor{title page header}{fg=white,bg=accent}
  \setbeamercolor{title page header}{fg=accent,bg=white}
  \begin{beamercolorbox}[wd=8cm,rounded=true,leftskip=0cm,sep=8pt,#1]{title page header}
      \raggedright\LARGE\bfseries\inserttitle\par
      \raggedright\large\semiboldfontitalic\insertsubtitle\par
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
  \setcounter{page}{-1}
  \oldmaketitle
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% SECTION %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\AtBeginSection[]{
  \addtocounter{framenumber}{-1}

  \setbeamertemplate{headline}{}
  \setbeamertemplate{footline}{}


  \settowidth{\@tempdima}{\insertsectionhead}
  %\settoheight{\@tempdimb}{\insertsectionhead}
  \begin{frame}
    \begin{center}
      \vspace{1cm}
      \tikz[baseline]{
            \draw[fill=accent,draw=accent,rounded corners] (-\@tempdima/2-60pt,-.6) rectangle (\@tempdima/2 + 60pt,.6) node [midway]{\color{white}\huge\sc\bfseries \insertsectionhead};
      }
    \end{center}
  \end{frame}
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% FRAME TITLE %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%\defbeamertemplate*{frametitle}{texsx}[1][]
%{
%
%  \settowidth{\@tempdimb}{
%    \ifx\insertframesubtitle\@empty
%      \insertframetitle
%    \else
%      \insertframetitle\ -\ \insertframesubtitle
%    \fi
%  }
%  \begin{beamercolorbox}[wd=\paperwidth,ht=1.2cm]{frametitle} 
%  \begin{tikzpicture}
%    \useasboundingbox (0,0) rectangle(\paperwidth,\paperheight);
%    \ifx\insertframesubtitle\@empty
%    {
%      \node[anchor=west, frametitle.fg] at (0.05*\paperwidth,0.61){\raggedright\insertframetitle};
%      \draw[line width=1pt, accent] (0.06*\paperwidth,0.31) -- (\@tempdimb+50pt,0.31);
%    }
%    \else
%    {
%
%      \node[anchor=west] at (0.05*\paperwidth,0.61){\raggedright\textcolor{accent}{\insertframetitle\ -\ \slshape\insertframesubtitle}};
%      \draw[line width=1pt, accent] (0.06*\paperwidth,0.31) -- (\@tempdimb+50pt,0.31);
%    }
%    %{
%    %  \node[anchor=west, frametitle.fg] at (0.05*\the\paperwidth,0.81){\raggedright\insertframetitle};
%    %  \node[anchor=west, framesubtitle.fg, font=\small\slshape] at (0.05*\the\paperwidth,0.41){\raggedright\insertframesubtitle};
%    %  \draw[line width=1pt, accent] (0.06*\the\paperwidth,0.11) -- (\@tempdimb+50pt,0.11);
%    %}
%    \fi
%  \end{tikzpicture}
%  \end{beamercolorbox}
%}



\defbeamertemplate*{frametitle}{left}[1][]
{
  \begin{beamercolorbox}[wd=\paperwidth,ht=1.2cm]{frametitle} 
    \settowidth{\@tempdima}{\insertframetitle}
    \settowidth{\@tempdimb}{\insertframesubtitle}
    \ifx\insertframesubtitle\@empty
      \begin{tikzpicture}[remember picture, overlay]
        \draw[fill=accent,draw=accent] (-0.55pt,0.6) rectangle (0.5,0);
        \draw[fill=accent,draw=accent,rounded corners] (0,0.6) rectangle (\@tempdima + 20pt,0) node [midway]{\color{white}\Large\bfseries \insertframetitle};
      \end{tikzpicture}
    \else
      \begin{tikzpicture}[remember picture, overlay]
        \draw[fill=accent,draw=accent] (-0.55pt,0.6) rectangle (0.5,0);
        \draw[draw=accent,rounded corners] (\@tempdima+10pt,0.6) rectangle (\@tempdima + \@tempdimb + 10pt,0) node [midway] {\color{accent}\large\semiboldfontitalic \ \ \insertframesubtitle};
        \draw[fill=accent,draw=accent,rounded corners] (0,0.6) rectangle (\@tempdima + 20pt,0) node [midway]{\color{white}\Large\bfseries \insertframetitle};
      \end{tikzpicture}
    \fi
  \end{beamercolorbox}
}

\defbeamertemplate{frametitle}{right}[1][]
{
  \begin{beamercolorbox}[wd=\paperwidth,ht=1.2cm]{frametitle} 
    \settowidth{\@tempdima}{\insertframetitle}
    \settowidth{\@tempdimb}{\insertframesubtitle}
    \ifx\insertframesubtitle\@empty
      \begin{tikzpicture}[remember picture, overlay]
      \draw[fill=accent,draw=accent] (\paperwidth-20pt,0.6) rectangle (\paperwidth - 14.9pt,0);
      \draw[fill=accent,draw=accent,rounded corners] (\paperwidth-\@tempdima-40pt,0.6) rectangle (\paperwidth - 15pt,0) node [midway]{\color{white}\Large\bfseries \insertframetitle};
      \end{tikzpicture}
    \else
      \begin{tikzpicture}[remember picture, overlay]
      \draw[fill=accent,draw=accent] (\paperwidth-20pt,0.6) rectangle (\paperwidth - 14.9pt,0);
      \draw[draw=accent,rounded corners] (\paperwidth-\@tempdima-\@tempdimb-35pt,0.6) rectangle (\paperwidth - \@tempdima - 30pt,0) node [midway] {\color{accent}\large\semiboldfontitalic \insertframesubtitle \ \ \ };
      \draw[fill=accent,draw=accent,rounded corners] (\paperwidth-\@tempdima-40pt,0.6) rectangle (\paperwidth - 15pt,0) node [midway]{\color{white}\Large\bfseries \insertframetitle};
      \end{tikzpicture}
    \fi
  \end{beamercolorbox}
}

\BeforeBeginEnvironment{frame}{
  \setbeamertemplate{frametitle}[left]
  \addtolength{\textheight}{-0.2pt}
}

\define@key{beamerframe}{right}[true]{
  \setbeamertemplate{frametitle}[right]
}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% STANDOUT %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\standout}[1]{
    \addtocounter{framenumber}{-1}

    \setbeamertemplate{headline}{}
    \setbeamertemplate{footline}{}

    \begin{frame}
      \begin{center}
        \vspace{1cm}
        \color{accent}\Large\bfseries \texttt{#1}
      \end{center}
    \end{frame}
}

%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%  TOC  %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%

%\newcommand\circled[1]{
%  \tikz[baseline=(char.base)]{
%    \node[shape=circle,draw,inner sep=2pt,thick] (char) {#1};
%  }
%}

%\newcommand\twodigits[1]{
%   \ifnum#1<10 0#1\else #1\fi
%}

\setbeamertemplate{section in toc}{
  {\Huge \textcolor{accent}{\textbf{\texttt{\inserttocsectionnumber}}}}
  \hskip1.5ex
  {\Large\bfseries \textcolor{black!90}{\inserttocsection}}
}

\let\oldtableofcontents\tableofcontents
\renewcommand\tableofcontents{
  \begin{frame}
  	\begin{tikzpicture}[remember picture, overlay]
  	  \draw[fill=accent,draw=accent,rounded corners] (10,0.4) rectangle (11,-0.6);
  	  \draw[fill=accent,draw=accent] (10.5,0.4) rectangle (14.75,-0.6);
  	  \pgftext[left,x=10.5cm,y=-0.1cm]{\color{white}\huge\sc\bfseries \contentsname};
  	\end{tikzpicture}
  
    \setbeamertemplate{headline}{} 
    \setbeamertemplate{footline}{}
  
    \bigskip
    \oldtableofcontents
  \end{frame}
  \setcounter{framenumber}{1}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% ENVIRONMENT %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Turn off shading for block title when rounded=true (by default, rounded = false)
%\pgfdeclareverticalshading[lower.bg,upper.bg]{bmb@transition}{200cm}{
%  color(0pt)=(lower.bg); color(4pt)=(lower.bg); color(4pt)=(upper.bg)
%}

\setbeamercovered{invisible}
\setbeamertemplate{frametitle continuation}{}
\setbeamertemplate{navigation symbols}{}
\setbeamertemplate{blocks}[rounded][shadow=false]

\setbeamertemplate{footline}{
  \ifnum\thepage>1
    \begin{beamercolorbox}[wd=\paperwidth,ht=-.5ex,dp=1.125ex,right]{page number in head/foot}
      \color{graydark}
      \the\numexpr\insertframenumber-1\relax/\the\numexpr\inserttotalframenumber-1\relax
      \hspace{12pt}
      \vspace{4pt}
    \end{beamercolorbox}
  \fi
}

\tcbuselibrary{skins}
\tcbuselibrary{skins,listings,breakable}
\newtcolorbox{accentbox}[3][]{
  enhanced,
  attach boxed title to top left={xshift=3mm,yshift=-3mm,yshifttext=-1mm},
  colback=#3!30,
  colframe=#3!160,
  colbacktitle=white,
  coltitle=#3!240,
  coltext=black,
  arc=4mm,boxrule=1.5pt,
  title=\textbf{#2}\ifx#1\@empty \else : \textit{#1}\fi,
  halign=flush left,
  boxed title style={size=small,colframe=#3!160,arc=2mm}
}

\renewenvironment{definition}[1][]{\begin{accentbox}[#1]{Definition}{lilla}}{\end{accentbox}}
\renewenvironment{note}[1][]{\begin{accentbox}[#1]{Note}{gray}}{\end{accentbox}}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%   REFERENCES   %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\addbibresource{bib/main.bib}

\DeclareFieldFormat{title}{\mkbibquote{#1}} % applies quotes to title in all entry types (@Misc, was missing them)


\def\references{
  \begin{frame}[allowframebreaks,right]{\textsc{References}}

  \nocite{*}
  \printbibliography[heading=none]
  \end{frame}
}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%   COMMON SHORTCUTS   %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\ie}{\textit{i.e.}, }
\newcommand{\eg}{\textit{e.g.}, }
\newcommand{\st}{\textit{s.t.} }

\newcommand{\quoteinline}[1]{``\textsl{#1}''}
