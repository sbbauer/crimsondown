
\ProvidesClass{harvardthesis}
\NeedsTeXFormat{LaTeX2e}


\newif\if@natbib      % true if including natbib
  \@natbibfalse
\DeclareOption{natbib}% includes natbib package
  {\@natbibtrue}


% FROM UW BUT CHANGED TO REPORT
\def\@f@ntsize{12pt}
\DeclareOption{10pt}{\def\@f@ntsize{10pt}}
\DeclareOption{11pt}{\def\@f@ntsize{11pt}}
\DeclareOption{12pt}{\def\@f@ntsize{12pt}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

\PassOptionsToClass{\@f@ntsize}{report}
\PassOptionsToClass{openany}{report}
\ProcessOptions
\LoadClass{report}

\if@natbib
  \RequirePackage{natbib}
\fi

% FROM HARVARD
\RequirePackage{geometry}
\RequirePackage{amssymb} %complains if not early enough

% Appendix package. Not necessary, but it does make managing appendices easier
\RequirePackage[titletoc]{appendix}

% Dissertation should be double-spaced throughout nodisplayskipstretch makes
% sure equations are single-spaced. Otherwise array-like objects (say pmatrix)
% look rather ugly.
\RequirePackage[nodisplayskipstretch,doublespacing]{setspace}
% This makes tables single-spaced by default. Since they are supposed to be
% double-spaced unless they are too long, need to set double-spacing for tables
% manually using \renewcommand{\arraystretch}{2} inside the table environment

% Add references, to Table of Contents, but not TOC itself, or list of tables
% and figures
\RequirePackage[
nottoc,notlot,notlof
]{tocbibind}

% Slightly tweak font spacing for aesthetics
\RequirePackage{microtype}

% You need the footmisc package with the stable option if you want to have
% footnotes inside section titles, for example to say that a particular chapter
% has been co-authored with someone. The multiple option ensures that there is a
% comma between two consecutive footnotes
\RequirePackage[stable,multiple]{footmisc}


% Nicer captions
\RequirePackage[font=small,format=plain,labelfont=bf,textfont=it]{caption}
\addtolength{\abovecaptionskip}{1ex}
\addtolength{\belowcaptionskip}{1ex}


% 3. Required and Optional fields
\newcommand\degreename[1]{\renewcommand\@degreename{#1}}
\newcommand\@degreename{\ClassError{harvardthesis}{No \noexpand\degreename given}{}}

\newcommand\degreefield[1]{\renewcommand\@degreefield{#1}}
\newcommand\@degreefield{\ClassError{harvardthesis}{No \noexpand\degreefield given}{}}

\newcommand\degreemonth[1]{\renewcommand\@degreemonth{#1}}
\newcommand\@degreemonth{\ClassError{harvardthesis}{No \noexpand\degreemonth given}{}}

\newcommand\degreeyear[1]{\renewcommand\@degreeyear{#1}}
\newcommand\@degreeyear{\ClassError{harvardthesis}{No \noexpand\degreeyear given}{}}

\newcommand\department[1]{\renewcommand\@department{#1}}
\newcommand\@department{\ClassError{harvardthesis}{No \noexpand\department given}{}}

\newcommand\principaladvisor[1]{\renewcommand\@principaladvisor{#1}}
\newcommand\@principaladvisor{\ClassError{harvardthesis}{No \noexpand\principaladvisor given}{}}

% Optional
\newcommand\secondadvisor[1]{\newcommand\@secondadvisor{#1}}

% 4. (Re)define commands and environments
\newcommand{\thesistitlepage}{%
  \begin{titlepage}
    \thispagestyle{empty}
    \null\vfil
    \addcontentsline{toc}{chapter}{Title Page}
    \begin{center}
      {\LARGE\bfseries {\@title}}\\[3em]
      A dissertation presented\\
      by\\[2em]
      {\Large\@author}\\[2em]
      to\\[2em]
      {\large\@department}\\[2em]
      in partial fulfillment of the requirements\\
      for the degree of\\
      \@degreename\\
      in the subject of\\
      \@degreefield\\[2em]
      Harvard University\\
      Cambridge, Massachusetts\\
      \@degreemonth\ \@degreeyear
    \end{center}
    \vfil\null
  \end{titlepage}
  \addtocounter{page}{1} % titlepage is not numbered by default
}

\newcommand{\copyrightpage}
{
  \thispagestyle{empty}
  \null\vfil
  \addcontentsline{toc}{section}{Copyright}
  \begin{center}
    \textcopyright\ \@degreeyear\ \@author\\
    All rights reserved.
  \end{center}
  \vfil\null
  \clearpage
}

\renewenvironment{abstract}%
{
  \clearpage
  % Standard spacing for the header
  \begin{spacing}{1.2}
    \begin{minipage}[t]{0.46\textwidth}
      \begin{flushleft}
        \ifx\@secondadvisor\undefined
        \emph{Dissertation Advisor:}\\
        {\bfseries\@principaladvisor}
        \else
        \emph{Dissertation Advisors:}\\
        {\bfseries\@principaladvisor\\\@secondadvisor}
        \fi
      \end{flushleft}
    \end{minipage}
    \begin{minipage}[t]{0.46\textwidth}
      \begin{flushright}
        \emph{Author:} \\
        {\bfseries\@author}
      \end{flushright}
    \end{minipage}
    \vspace{2em}
    \begin{center}
      {\large\bfseries\@title}
    \end{center}
    \vspace{2em}
  \end{spacing}
  \addcontentsline{toc}{section}{Abstract}
  \section*{\centering \abstractname}
}%
{\clearpage}

% GSAS: "Table of contents, lists of figures and tables can be single-spaced".
% Let's redefine them to be single-spaced.

% Save the latex commands
\let\LaTeXTOC\tableofcontents
\let\LaTeXLOT\listoftables
\let\LaTeXLOF\listoffigures

% Redefine them
\renewcommand{\tableofcontents}%
{
    \addcontentsline{toc}{section}{Table of Contents}
  \begin{spacing}{1.2} % 1.2 looks nicer than 1
    \LaTeXTOC
  \end{spacing}
}
\renewcommand{\listoftables}%
{
  \addcontentsline{toc}{section}{List of Tables}
  \begin{spacing}{1.2}
    \LaTeXLOT
  \end{spacing}
}
\renewcommand{\listoffigures}%
{
  \addcontentsline{toc}{section}{List of Figures}
  \begin{spacing}{1.2}
    \LaTeXLOF
  \end{spacing}
}

\newenvironment{acknowledgments}
{
  \clearpage
  \addcontentsline{toc}{section}{Acknowledgments}
  \begin{center}
       \Large  Acknowledgments
  \end{center}
  \par\vspace*{.085\textheight}
}
{\clearpage}

\newenvironment{dedication}
{
  \clearpage
  \par\vspace*{.2\textheight}
  \begin{quotation}
}
{\end{quotation}\clearpage}


% Quotations should be single-spaced
\expandafter\def\expandafter\quote\expandafter{\quote\singlespacing}
\expandafter\def\expandafter\quotation\expandafter{\quotation\singlespacing}

% Footnotes should single-spaced (setspace default), but there should be
% double-spacing between footnotes.
\setlength{\footnotesep}{0.8\baselineskip}

% for section titles
\RequirePackage[medium, md, sc]{titlesec}
\setlength{\headheight}{15pt}
\pagestyle{plain}
\RequirePackage{titling}

% for chapter pages
\RequirePackage{quotchap}
\qsetcnfont{baskervillef}

% align chapters with and without numbers
\makeatletter
\renewcommand{\@makechapterhead}[1]{%
  \chapterheadstartvskip%
  {\size@chapter{\sectfont\raggedleft
    {\chapnumfont
      \ifnum \c@secnumdepth >\m@ne%
        \if@mainmatter\thechapter\else\phantom{\thechapter}%
      \fi\else\phantom{\thechapter}\fi
      \par\nobreak}%
    {\raggedleft\advance\leftmargin10em\interlinepenalty\@M #1\par}}
  \nobreak\chapterheadendvskip}}
\makeatother

% give some more space to chapter pages
\renewcommand{\chapterheadstartvskip}{\vspace*{-180pt}}

\RequirePackage{lettrine}
\RequirePackage{fancyhdr}

\renewcommand{\setthesection}{\arabic{chapter}.A\arabic{section}}

\RequirePackage[tight,nice]{units}
\RequirePackage{url}

% FONT
\RequirePackage[T1]{fontenc}
\RequirePackage[p,osf]{baskervillef}
\RequirePackage[varqu,varl,var0]{inconsolata}
\RequirePackage[scale=.95,type1]{cabin}
\RequirePackage[baskerville,vvarbb]{newtxmath}
\RequirePackage[cal=boondoxo]{mathalfa}

% Indicate that LaTeX can stop reading this file. LaTeX will ignore anything
% after this line. Not required, but good practice.
\endinput
