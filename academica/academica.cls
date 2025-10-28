\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{academica}


\LoadClass[12pt]{book} % should be same as \LoadClass[onecolumn,twoside,12pt]{book}
%\LoadClass[oneside,12pt]{book}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% PACKAGES %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{graphicx} % allow use of \includegraphics
\RequirePackage[a4paper]{geometry} % sets page geometry style
\RequirePackage{xcolor} % provides palette of default colornames, plus allow definition of custom colors and rewrite of default ones
\RequirePackage{titlesec} % easily modify appereance of chapters and sections
\RequirePackage{fontspec} % easily modify appereance of chapters and sections
% \RequirePackage[T1]{fontenc} % provides encoding of characters not provided by font




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
  \RequirePackage[pdfa]{hyperref} % manage references
\else
  \RequirePackage{hyperref}
\fi

% Sets text to a light font.
% We firstly load `cmbright` that sets both text and math, to have a light math, matching the SopiaPro style.
% Then we overwrite the text font with SofiaPro.
\ifacademica@light
  % Set font to use Computer Modern Bright (works also with pdfLatex)
  \RequirePackage{cmbright} % light version of Computer Modern (default LaTex font)

  % Set font to use SofiaPro (need LuaLatex/XeLatex engine)

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




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% PARAMETERED CLASS OPTIONS %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% More complex options that allow passing strings
\RequirePackage{kvoptions}
\SetupKeyvalOptions{prefix={academica@}}
\DeclareStringOption[]{banner}[] % class option banner
\ProcessKeyvalOptions{academica}\relax



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% COLORS %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\definecolor{lilla}{HTML}{B4B5EE}

\colorlet{accent}{lilla!160}
\colorlet{accentmedium}{lilla!240}
\colorlet{accentdark}{accent!320}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% PAGING %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\academica@unisep{.5em}
\def\academica@se@and{.2ex}
\def\academica@se@qual{1ex}
\def\academica@se@sep{2em}

\geometry{%
    hcentering,%
    bindingoffset=.025\paperwidth,%
    outer=.075\paperwidth,%
    nofoot,nomarginpar,%
    vdivide={.08\paperheight,*,.06\paperheight}%
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
  \def\@evenhead{{\footnotesize \textcolor{accentdark}{\header}}\hfill\thepage}%
  \def\@oddhead{\thepage\hfill{\footnotesize \textcolor{accentdark}{\header}}}%
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% ENVIRONMENT %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\acknowledgements{\chapter*{\textcolor{accentmedium}{Acknowledgements}}}
\def\abstract{\chapter*{\textcolor{accentmedium}{Abstract}}\addcontentsline{toc}{chapter}{Abstract}}
\def\summary{\chapter{\textcolor{accentmedium}{Summary}}}

\newenvironment{titlelike}[1]{
    \cleardoublepage\thispagestyle{empty}%
    \def\academica@titlelike{#1}%
    \vspace*{\z@\@plus.3fil}%
    \begin{\academica@titlelike}%
}{
    \end{\academica@titlelike}%
    \vspace*{\z@\@plus.6fil}%
    \newpage\thispagestyle{empty}%
}

\newenvironment{dedication}{\begin{titlelike}{flushright}\begin{itshape}}{\end{itshape}\end{titlelike}}

% custom title body:
% chaptertitle <empty> bigchapternumber
\newcommand{\chaptertitleformat}[1]{
  #1
  \hfill
  {\fontsize{100}{60}\selectfont\textcolor{accent}{\thechapter}}
}

\newcommand{\newchapterstyle}{
  \titleformat{\chapter}[block]
    {\huge\bfseries} % Format of the whole line
    {} % Label
    {0pt} % Separation between label and title body
    {\chaptertitleformat} % title body
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
  \newchapterstyle
}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%   TITLE   %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\def\@date{\begingroup\expandafter\advance\expandafter\year\ifnum\month>3 -1 \else -2 \fi\the\year-\advance\year1 \the\year\endgroup}

\def\@banner{%
  \ifx\academica@banner\@empty%
    \textcolor{white}{\rule{\textwidth}{40pt}}
  \else%
    \@for\@ban:=\academica@banner\do{\includegraphics[width=\textwidth]{banners/\@ban.pdf}\\}
  \fi%
  \vfill
}

% Defines a new field 
\newcommand{\deffield}[1]{%
  % Define storage macro \@<name> (empty initially)
  \expandafter\newcommand\csname @#1\endcsname{}%
  % Define setter: \name{<value>} sets \@<name>
  \expandafter\newcommand\csname #1\endcsname[1]{%
    \expandafter\gdef\csname @#1\endcsname{##1}%
  }%
}

% Define multiple fields by extending `\deffield`.
% Takes a comma-separated list as input
\newcommand{\deffields}[1]{%
  \@for\@field:=#1\do{%
    \expandafter\deffield\expandafter{\@field}%
  }%
}

% Simply prints the field value after printing the field name
\def\show#1{%
  \if\csname @#1\endcsname\@empty
  \else
    \textcolor{accentdark}{\textsc{\csname #1name\endcsname}}\\
    \textit{\csname @#1\endcsname}\par
    \vskip2em\relax
  \fi%
}

\newcount\@numitems

\newcommand{\countitems}[1]{%
  \@numitems\z@%
  \expandafter\@for\expandafter\@item\expandafter:\expandafter=\csname @#1\endcsname\do{\advance\@numitems\@ne}%
}

% Alternative version of `show` that use a singular/plural version of the field name
% depending on the number of elements.
\def\shows#1{%
  \if\csname @#1\endcsname\@empty
  \else
    \countitems{#1}
    \ifnum\the\@numitems>1
      \textcolor{accentdark}{\textsc{\csname #1name\endcsname s}}\\
    \else
      \textcolor{accentdark}{\textsc{\csname #1name\endcsname}}\\
    \fi
    \expandafter\@for\expandafter\entry\expandafter:\expandafter=\csname @#1\endcsname\do{%
      \textit{\entry}\par
    }%
    \vskip2em\relax
  \fi
}

% Custom field definitions
\deffields{overtitle,candidate,supervisor,cosupervisor,tutor,institutecontacts,authorcontacts}

% Field names
\def\authorname{Author}
\def\candidatename{Candidate}
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
            %\let\footnotesize\small
            %\let\footnoterule\relax
            {\@banner}
            \begin{center}
              {\textcolor{accentdark}{\textsc{\large \@overtitle}}\par}
                \vskip 1em\@plus1fill\relax
                {\fontsize{30}{20}\selectfont\bfseries\@title\par}
                \vskip 5em\@plus1fill\relax
                {\large%
                    \parbox[t]{0.40\linewidth}{
                        \shows{author}
                        \shows{candidate}
                    }
                    \qquad
                    \parbox[t]{0.40\linewidth}{
                        \shows{supervisor}
                        \shows{cosupervisor}
                        \shows{tutor}
                    }
                }
                \par\vskip 1em\@plus1fill\relax%
                {\large\@date}\par
            \end{center}
        \end{minipage}
    \end{titlepage}
    {\parindent\z@\relax
        \show{institutecontacts}
        \show{authorcontacts}
        \ifx\@rights\@empty\else\vfill\@rights\par\fi
    }
}
