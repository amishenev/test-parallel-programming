\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{parallel-programming}[2023/03/28 v1.0.0]

\RequirePackage{xkvltxp}
\LoadClass[14pt]{extarticle}

%% Russian language in UTF-8

\RequirePackage[utf8]{inputenc}
\RequirePackage[T2A]{fontenc}
\RequirePackage[english,russian]{babel}
% \RequirePackage{csquotes}
\RequirePackage{iflang}

\RequirePackage[left=3cm, right=2.5cm, top=2cm, bottom=2cm]{geometry}

%% Эти пакеты слишком часто используются, чтобы их не включать

\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage{amsfonts}
\RequirePackage{amsxtra}

%% Поддержка цветов и чего-то еще графического, в том числе в таблицах.

\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{colortbl}

%% Эти пакеты используются для некоторых таблиц и других визуальных элементов.
\RequirePackage{multirow}
\RequirePackage{adjustbox}
\RequirePackage{tabularx}

%% Делаем правильные подписи в правильных местах.

\RequirePackage{caption}
\RequirePackage{floatrow}

%% Перечисления по умолчанию слишком разрежены.

\RequirePackage{enumitem}
\setlist{nosep}

%% Полуторный межстрочный интервал
\RequirePackage{setspace}
\onehalfspacing

%% Абзацный отступ по ГОСТу - пять букв. Это примерно столько.

\setlength{\parindent}{1.25cm}

%% Не используем буллеты.

\renewcommand\labelitemi{---}

%% На первом уровне нумерованных списков ставим русские буквы, на втором - цифры.

%%% asbuk работал бы неплохо, но он включает в нумерацию букву "з", которую ГОСТ не разрешает. И, может быть, что-то еще.

\def\asbukx#1{\expandafter\@asbukx\csname c@#1\endcsname}
\def\@asbukx#1{\ifcase#1\or a\or б\or в\or г\or д\or е\or ж\or и\or к\or л\or м\or н\or п\or р\or с\or т\or у\or ф\or х\or ц\or ш\or щ\or э\or ю\or я\fi}

\def\Asbukx#1{\expandafter\@Asbukx\csname c@#1\endcsname}
\def\@Asbukx#1{\ifcase#1\or А\or Б\or В\or Г\or Д\or Е\or Ж\or И\or К\or Л\or М\or Н\or П\or Р\or С\or Т\or У\or Ф\or Х\or Ц\or Ш\or Щ\or Э\or Ю\or Я\fi}

\AddEnumerateCounter{\Asbukx}{\@Asbukx}{М}
\AddEnumerateCounter{\asbukx}{\@asbukx}{м}

\renewcommand\labelenumii{\arabic{enumii})}
\renewcommand\theenumii{\arabic{enumii}}

%% "Тонкая" настройка теховских штрафов при формировании абзацев.

\sloppy
\binoppenalty=10000
\relpenalty=10000
\clubpenalty=10000
\widowpenalty=10000

%% Делаем русские варианты знаков неравенств.

\let\le\leqslant
\let\leq\leqslant
\let\ge\geqslant
\let\geq\geqslant

%% Подписи к рисункам, таблицам, листингам.

\floatstyle{plaintop}
\restylefloat{algorithm}

\floatsetup[figure]{style=plain, capposition=bottom}
\captionsetup[figure]{
    labelsep=endash,
    singlelinecheck=false,
    labelfont={normalsize,md},
    justification=centering,
    position=bottom
}
\floatsetup[table]{style=plain, capposition=top}
\captionsetup[table]{
    labelsep=endash,
    singlelinecheck=false,
    labelfont={normalsize,md},
    justification=justified,
    position=top
}
\floatsetup[algorithm]{style=plain, capposition=top}
\captionsetup[algorithm]{
    labelsep=endash,
    singlelinecheck=false,
    labelfont={normalsize,md},
    justification=justified,
    position=top
}
\floatsetup[lstlisting]{style=plain, capposition=top}
\captionsetup[lstlisting]{
    labelsep=endash,
    singlelinecheck=false,
    labelfont={normalsize,md},
    justification=justified,
    position=top
}

%% Библиография по ГОСТу. Используем только бибер.

\RequirePackage[
    backend=biber,
    bibencoding=utf8,
    sorting=nyt,
    sortcites=true,
    bibstyle=gost-numeric,
    citestyle=numeric-comp,
    autolang=other
]{biblatex}

%% Патчи к стилевику библиографии.

% biblatex-3.4 и biblatex-gost
% Эти штуки появились недавно, и кажется, что не во всех дистрибутивах они настроены правильно.
% В любом случае, эта функциональность нам не нужна, ее можно заткнуть таким вот образом.
\renewcommand*{\mkgostheading}[1]{#1}
\providecommand{\datecircaprint}{}
\providecommand{\dateeraprintpre}[1]{}
\providecommand{\mkyearzeros}{}
\providecommand{\dateeraprint}[1]{}
\providecommand{\dateuncertainprint}{}

\renewbibmacro*{//}{\nopunct\printtext{\addspace\mbox{//}\addnbspace}}
\renewcommand*{\newblockpunct}{\textemdash\addnbspace\bibsentence}
\DeclareFieldFormat*{pages}{\mkpageprefix[bookpagination][\mbox]{#1}}
\DeclareFieldFormat*{labelnumberwidth}{#1}
\DefineBibliographyStrings{english}{pages={p\adddot}}
\DefineBibliographyExtras{russian}{\protected\def\bibrangedash{\textendash\penalty\hyphenpenalty}}

% Это ставит сначала русские, потом иностранные источники

\DeclareSourcemap{
    \maps[datatype=bibtex]{
        \map{
            \step[fieldsource=language, match=russian, final]
            \step[fieldset=presort, fieldvalue={a}]
        }
        \map{
            \step[fieldsource=language, notmatch=russian, final]
            \step[fieldset=presort, fieldvalue={z}]
        }
    }
}

% Сделаем ссылки URL нормальным шрифтомs
\renewcommand\UrlFont{\rmfamily}

% Уберём пробел перед разделяющим двоеточием
\renewcommand*{\addcolondelim}{\addcolon\space}

% Добавляем чей-то драйвер от online, чтобы "электронный ресурс" отражался по ГОСТу.

\DeclareBibliographyDriver{online}{%
    \usebibmacro{bibindex}%
    \usebibmacro{begentry}%
    \usebibmacro{heading}%
    \newunit
    \usebibmacro{author/editor}%
    \setunit*{\labelnamepunct}%
    \usebibmacro{title}%
    \addspace\foreignlanguage{russian}{[Электронный ресурс]}
    \setunit{\addcolondelim}%
    \usebibmacro{translation}%
    \def\bbx@gost@respdelim{\setunit{\respdelim}}% ----- Resp starts -----
    \usebibmacro{byauthor}%
    \setunit*{\resppunct}%
    \iflistundef{organization}
    {}
    {%
        \setrespdelim%
        \printlist{organization}%
        \setunit*{\resppunct}%
    }%
    \usebibmacro{credits}%
    \setunit*{\resppunct}%
    \usebibmacro{byeditor}%
    \setunit*{\resppunct}%
    \usebibmacro{bytranslator+others}%
    \newunit\newblock
    \printfield{version}%
    \newunit\newblock
    \printlist[semicolondelim]{specdata}%
    \newunit\newblock
    \usebibmacro{date}%
    \newunit\newblock
    \printupdate%
    \newunit\newblock
    \printfield{systemreq}%
    \newunit\newblock
    \usebibmacro{doi+eprint+url+note}%
    \newunit\newblock
    \usebibmacro{addendum+pubstate}%
    \setunit{\bibpagerefpunct}\newblock
    \usebibmacro{pageref}%
    \newunit\newblock
    \usebibmacro{related:init}%
    \usebibmacro{related}%
    \usebibmacro{finentry}%
}

%% Листинги, по умолчанию - C++

\RequirePackage{listings}

\definecolor{dkgreen}{rgb}{0,0.6,0}
\definecolor{gray}{rgb}{0.5,0.5,0.5}
\definecolor{mauve}{rgb}{0.58,0,0.82}	

\lstset{ 
  language=C++,                 % the language of the code
  % backgroundcolor=\color{white},   % choose the background color; you must add \usepackage{color} or \usepackage{xcolor}; should come as last argument
  basicstyle=\footnotesize\ttfamily,        % the size of the fonts that are used for the code
  breakatwhitespace=false,         % sets if automatic breaks should only happen at whitespace
  breaklines=true,                 % sets automatic line breaking
  captionpos=b,                   % sets the caption-position to bottom
  commentstyle=\color{dkgreen},    % comment style
  deletekeywords={...},            % if you want to delete keywords from the given language
  escapeinside={\%*}{*)},          % if you want to add LaTeX within your code
  extendedchars=\true,              % lets you use non-ASCII characters; for 8-bits encodings only, does not work with UTF-8
  firstnumber=1,                % start line enumeration with line 1000
  frame=single,	                   % adds a frame around the code
  keepspaces=true,                 % keeps spaces in text, useful for keeping indentation of code (possibly needs columns=flexible)
  keywordstyle=\color{blue},       % keyword style
  morekeywords={*, omp, pthread_t, cl_kernel, cl_program, size_t},            % if you want to add more keywords to the set
  otherkeywords={pragma, include, ifdef, \#},
  numbers=left,                    % where to put the line-numbers; possible values are (none, left, right)
  numbersep=14pt,                   % how far the line-numbers are from the code
  numberstyle=\footnotesize\color{black}, % the style that is used for the line-numbers
  rulecolor=\color{black},         % if not set, the frame-color may be changed on line-breaks within not-black text (e.g. comments (green here))
  showspaces=false,                % show spaces everywhere adding particular underscores; it overrides 'showstringspaces'
  showstringspaces=false,          % underline spaces within strings only
  showtabs=false,                  % show tabs within strings adding particular underscores
  stepnumber=1,                    % the step between two line-numbers. If it's 1, each line will be numbered
  stringstyle=\color{mauve},     % string literal style
  tabsize=2,	                   % sets default tabsize to 2 spaces
  title=\relax,                   % \lstname show the filename of files included with \lstinputlisting; also try caption instead of title
  inputpath=listings, %relative path to the listings,
  xleftmargin=5.0ex, % left indent
  % belowskip=-2.5em, % Не понятно для чего отрицательный скип
  % aboveskip=0.5em,
  belowskip=0em,
  inputencoding=utf8
}