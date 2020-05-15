
\ProvidesClass{harvardchapter}
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
\RequirePackage[nottoc,notlot,notlof]{tocbibind}

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
% \RequirePackage{titling}
%
% \RequirePackage{lettrine}
% \RequirePackage{fancyhdr}

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
