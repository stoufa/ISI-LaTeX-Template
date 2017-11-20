
%========= File containing the ISIPFE LaTex Class =========%
% Produced based on "mqthesis.cls" and isipfe.cls v1       %
%                                                          %
% Copyright (C) ISI - All Rights Reserved                  %
% Proprietary                                              %
% Written by Med Hossam <med.hossam@gmail.com>, April 2016 %
%                                                          %
% @author: HEDHILI Med Houssemeddine                       %
% @linkedin: http://tn.linkedin.com/in/medhossam           %
%==========================================================%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{isipfe}[15/04/2016 ISI PFE LaTeX Class]

% ifthenelse for if loops
\RequirePackage{ifthen}

% if two condidates
\newboolean{isBinomal}
\setboolean{isBinomal}{false}
\DeclareOption{isBinomal}{\setboolean{isBinomal}{true}}

\newboolean{wantToTypeCompanyAddress}
\setboolean{wantToTypeCompanyAddress}{false}
\DeclareOption{wantToTypeCompanyAddress}{\setboolean{wantToTypeCompanyAddress}{true}}

% finished processing options
\ProcessOptions\relax

% load the book class using a4paper
\LoadClass[11pt,a4paper, oneside]{book}
\usepackage[a4paper]{geometry}

% give the header a bit more room for fancyhdr below
% otherwise LaTeX will spew on each page
\addtolength{\headheight}{2.5pt}

% first set to zero ... 
\setlength{\oddsidemargin}{-1in}
\setlength{\evensidemargin}{-1in}
\setlength{\topmargin}{-1in}       

% adjust these if printer is off by a bit
\setlength{\hoffset}{0mm}
\setlength{\voffset}{0mm}

% PS also that the optimal number of characters per line 
% for readability is only 60-70, we're over so we'll be a
% bit more generous on the evensidemargin

\addtolength{\oddsidemargin}{22mm} 
\addtolength{\evensidemargin}{22mm}
\addtolength{\topmargin}{20mm}

% set up some of the spacing
\setlength{\marginparwidth}{40pt}  
\setlength{\marginparsep}{10pt}
\setlength{\headsep}{0.2in}

% A4 dimensions [mm]: 209.903 x 297.039
\setlength{\textwidth}{21 cm}
\setlength{\textheight}{30 cm}

% fix up width
\addtolength{\textwidth}{-\oddsidemargin}
\addtolength{\textwidth}{-\evensidemargin}
% now we've added 2inches in setting up margins
\addtolength{\textwidth}{-2in}

% fix up height
\addtolength{\textheight}{-2\topmargin}
\addtolength{\textheight}{-\headheight}
\addtolength{\textheight}{-\headsep}
\addtolength{\textheight}{-\footskip}
% now we've added 2inches in setting up margins
\addtolength{\textheight}{-2in}

\brokenpenalty=10000   % dunno what this does, maybe handy

% this stops one figure taking up a whole page and lets more text onto
% the one page when a figure exists
\renewcommand\floatpagefraction{0.8} %   Default = 0.5

%% Disable hyphenation
\usepackage[none]{hyphenat}

%% Defining section, subsection and subsubsection spacing
\usepackage{titlesec}
\titlespacing*{\section}{7mm}{12pt}{8pt}
\titlespacing*{\subsection}{15mm}{12pt}{8pt}
\titlespacing*{\subsubsection}{18mm}{12pt}{6pt}

% use 1.5 line spacing
%\renewcommand{\baselinestretch}{1.5}
\usepackage{setspace}
\setstretch{1.6}

\setlength{\parindent}{12mm}
%\setlength{\parskip}{3pt}

%%% load the required packages
% fancyhdr for nice, fancy headings
\RequirePackage{fancyhdr}
% ccaption for good caption handling
%\RequirePackage{ccaption}
% xspace so that spaces after commands are handled correctly
\RequirePackage{xspace}

%================ Languages used in the doc ================%
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
% @author: Stoufa
% Package babel-french Warning: Option `frenchb' for Babel is *deprecated*
%\usepackage[english,arabic,frenchb]{babel}
\usepackage[english,arabic,french]{babel}

%%%%%%%%%%%

\frenchbsetup{LowercaseSuperscripts=false}
\usepackage{csquotes}
\PassOptionsToPackage{%
    backend=biber, %instead of bibtex
    %backend=bibtex8,bibencoding=ascii,%
    %language=autobib,%
    language=auto,
    %language=french,
    %autocite=inline,
    %style=numeric-comp,%
    %style=authoryear-comp, % Author 1999, 2010
    %style=authoryear,%
    %style=alphabetic,%
    style=ieee,
    %bibstyle=authoryear,dashed=false, % dashed: substitute rep. author with ---
    %sorting=nty, % name, year, title
    sorting=none, % name, year, title
    %maxbibnames=3, % default: 3, et al.
    %backref=true,%
    %hyperref=true,
    %natbib=true % natbib compatibility mode (\citep and \citet still work)
}{biblatex}
% @author: Stoufa
% the option `backend=bibtex` is mandatory to avoid the “no \citation commands” error
% https://tex.stackexchange.com/questions/18045/problem-with-compiling-bibtex-no-citation-commands-error
\usepackage[backend=bibtex]{biblatex}
%\renewcommand*{\bibfont}{\small\raggedright}
%\DefineBibliographyExtras{french}{\renewcommand*\mkbibnamelast[1]{#1}}
\addbibresource{biblio.bib}
%\DefineBibliographyStrings{french}{%
%  bibliography = {Bibliographie},
%}

%============== To Enable List Customization ==============%
\usepackage{enumitem}
\usepackage{datatool}% http://ctan.org/pkg/datatool
\newcommand{\sortitem}[2][\relax]{%
  \DTLnewrow{list}% Create a new entry
  \DTLnewdbentry{list}{sortlabel}{#1}
  \DTLnewdbentry{list}{description}{
      \begin{minipage}[l]{0.1\columnwidth}
            ~\textbf{#1}
        \end{minipage}
        \begin{minipage}[l]{0.05\columnwidth}
            \textbf{=}
        \end{minipage}
        \begin{minipage}[l]{0.85\columnwidth}
            #2
        \end{minipage}
  }% Add entry description
}
\newenvironment{acronyms}{%
  \DTLifdbexists{list}{\DTLcleardb{list}}{\DTLnewdb{list}}% Create new/discard old list
}{%
  \DTLsort{sortlabel}{list}% Sort list
  \begin{itemize}%
    \DTLforeach*{list}{\theDesc=description}{%
      \item \theDesc}% Print each item
  \end{itemize}%
}

%================= Defining Custom Colors =================%
\usepackage[table]{xcolor}
\definecolor{isiBlue}{RGB}{31, 78, 121}

%================= configuring minitoc ==================%
\usepackage[french]{minitoc}
\mtcsettitle{minitoc}{Plan}
\setcounter{minitocdepth}{1}
\mtcsetrules{minitoc}{off}
\mtcsetoffset{minitoc}{-1.0em}

%% disabling chapter numbers
\newcommand{\filterminitoc}[1]{#1}
\renewcommand{\thesection}{\csname filterminitoc \endcsname{\arabic{chapter}.}\arabic{section}}
\newcommand{\minitocsection}{\begingroup\renewcommand{\filterminitoc}[1]{}\minitoc\endgroup}

%=============== Customizing Chapters Names ===============%
%@author: Stoufa
%Package pstcol Warning:
%************************************
%(pstcol) The package `pstcol' is obsolet!
%(pstcol) You should use `pstricks' directly:
%(pstcol) \usepackage{pstricks}
%(pstcol) ************************************
%\usepackage{pstcol}
\usepackage{pstricks}
\makeatletter
\def\thickhrulefill{\leavevmode \leaders \hrule height 1.2ex \hfill \kern \z@}

\def\@makechapterhead#1{
    \vspace*{30\p@}%
    {\parindent \z@ \centering \reset@font
        \thickhrulefill\quad 
        \scshape\bfseries\textit{\@chapapp{}  \thechapter}  
        \quad \thickhrulefill
        \par\nobreak
        \vspace*{10\p@}%
        \interlinepenalty\@M
        \hrule
        \vspace*{10\p@}%
        \Huge \bfseries #1 \par\nobreak
        \par
        \vspace*{10\p@}%
        \hrule
        \vskip 50\p@
    }
    \minitocsection
    \thispagestyle{empty}%
    \newpage
}
\def\@makeschapterhead#1{\hbox{%
    \huge\hbox{\textbf{#1}}%
}\par\vskip 1cm}

%============== Table & Figure Captions Style ==============%

\usepackage{caption}
\captionsetup[table]{
  labelfont=bf,
  labelsep = newline,
  name = Tableau,
  justification=justified,
  singlelinecheck=false,%%%%%%% a single line is centered by default
  labelsep=colon,
  skip = \medskipamount}

\captionsetup[figure]{
  labelfont=bf,
  labelsep = newline,
  name = Figure,
  justification=centering,
  singlelinecheck=false,
  labelsep=colon,
  skip = \medskipamount}

%%%%% Fancyhdr stuff
% define how headers are marked, for details, see fancyhdr docs
%\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
%\renewcommand{\sectionmark}[1]{\markright{\thesection\ #1}}
% define where sections, chapters and pagenumbers are put
% see fancyhdr docs for details

% the \nouppercase stops book.cls making the contents, bibliography
% and index headers from being all in uppercase.
% The options used here are essentially that in Lamport's book, but
% with small caps for the headings.
\fancyhf{}
%\fancyhead[LE,RO]{\nouppercase{\thepage}}
%\fancyhead[L]{\nouppercase{\leftmark}}
\renewcommand{\headrulewidth}{0.3pt}
\renewcommand{\footrulewidth}{0.3pt}
\pagestyle{fancy}
\lhead{\nouppercase{\leftmark}}
\rfoot{\centering \thepage}

%=============== Defining Fancy Page Styles ===============%

\fancypagestyle{frontmatter}{%
  \fancyhf{}% clear all header and footer fields
  \renewcommand{\footrulewidth}{0.3pt}%
  \renewcommand{\headrulewidth}{0pt}%
  \fancyfoot[r]{\footnotesize \thepage}%
}

\fancypagestyle{lscape}{
  \fancyhf{}
  \renewcommand{\footrulewidth}{0pt}
  \renewcommand{\headrulewidth}{0pt}
  %\rhead{\vspace{12cm}\rotatebox{90}{\footnotesize \thepage}}
  %\lfoot{\vspace{-88mm}\rotatebox{90}{\nouppercase{\leftmark}}}
}

\fancypagestyle{plain}{
  \fancyhf{}
  \renewcommand{\footrulewidth}{0.3pt}
  \renewcommand{\headrulewidth}{0pt}
  \fancyfoot[c]{\footnotesize \thepage}
}

\fancypagestyle{cover}{
  \fancyhf{}
  \renewcommand{\footrulewidth}{0pt}
  \renewcommand{\headrulewidth}{0pt}
  \fancyfoot[C]{{\noindent\makebox[\textwidth][c]{Année Universitaire \@collegeYear}}}
}

\fancypagestyle{backcover}{
  \fancyhf{}
  \renewcommand{\footrulewidth}{0pt}
  \renewcommand{\headrulewidth}{0pt}
  \setlength{\headheight}{0mm}
  \setlength{\footskip}{0mm}

  %%% ISI Footer %%%
  \fancyfoot[C]{
    \centering\color{isiBlue}
    {\ifthenelse{\boolean{wantToTypeCompanyAddress}}
    {% IF TRUE
        \makebox[\textwidth][c]{\rule{1.03\columnwidth}{1pt}}
        \makebox[\textwidth][c]{
        	\small\textLR{\@companyEmail} \footnotesize{\textAR{البريد الالكتروني :}}
        	\footnotesize{\textLR{\@companyFax}\textAR{الفاكس : }}
        	\footnotesize{\textLR{\@companyTel}\textAR{الهاتف : }}
        	\footnotesize{\textAR{\@companyAddressAR}}
        }
        \makebox[\textwidth][c]{
        	\small\textLR{\@companyAddressFR}
        	~~\small\textLR{\textbf{Tél} : \@companyTel}
        	~\small\textLR{\textbf{Fax} : \@companyFax}
        	~\small\textLR{\textbf{Email} : \@companyEmail}
        }
        \vspace{-3mm}
    }{\vspace{8mm}}}
    \makebox[\textwidth][c]{\rule[2mm]{1.03\columnwidth}{1pt}}
    \makebox[\textwidth][c]{
    	\small\textLR{isi@isim.rnu.tn} \footnotesize{\textAR{البريد الالكتروني : }}
    	~~~~~\footnotesize{\textLR{71 706 698}\textAR{الفاكس : }}
    	~~~~~\footnotesize{\textLR{71 706 164}\textAR{الهاتف : }}
    	~~~~~\footnotesize{\textAR{ أريانة }}\textLR{2080}\textAR{ نهج أبو الريحان الباروني }\textLR{2}
    }
    \makebox[\textwidth][c]{
    	\small\textLR{2, Abou Raihane Bayrouni 2080 l'Ariana}
    	~~~~~~~~\small\textLR{\textbf{Tél} : 71 706 164}
    	~~~~~~~~\small\textLR{\textbf{Fax} : 71 706 698}
    	~~~~~~~~\small\textLR{\textbf{Email} : isi@isim.rnu.tn}
    }
  }
}

% standard graphics package for inclusion of images and eps files into LaTeX document
\usepackage{graphicx}
\usepackage{graphics}
\usepackage{float}