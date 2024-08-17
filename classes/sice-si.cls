% sice cls file for LuaLaTeX and uplatex
% © [2023/08/31] [Tadaaki Sone]

% ref:https://www.sice-si.org/conf/si2023/paper.php

\ProvidesClass{sice-si}[2023/08/31 sice-si]

% (u)pLaTeX非互換パッケージに対して互換させるパッチを読み込む命令
% LuaLaTeXでは不要
\RequirePackage{plautopatch}

\NeedsTeXFormat{LaTeX2e}

% 2カラム,A4,フォントサイズ10pt
\LoadClass[
    two column,
    paper=a4,
    fontsize=10pt,
    disablejfam,
    head_space=20mm,
    foot_space=27mm,
    gutter=15mm,
    fore-edge=15mm,
    column_gap=7.5mm,
    linegap=.5zh,]
    {jlreq}

\RequirePackage{ifptex}
\RequirePackage{ifluatex}


\PassOptionsToPackage{hyphens}{url}
\usepackage{secdot} % sectionの数字の後のドットの制御
\usepackage{setspace} % 行間設定用パッケージ
\setstretch{0.8} % 行間設定
\sectiondot{section} % sectionの数字の後のドットの有効化
\usepackage{caption} % キャプションとサブキャプションのパッケージ
\usepackage{subcaption}
\usepackage{here} % 好きな位置にfigなどを置くためのパッケージ
\usepackage[hyphens]{xurl} % URLを表示するためのパッケージ、ハイフンでの改行を許可
\urlstyle{same} % URLの表示形式を本文と同じにする
\usepackage{enumitem} % 高機能番号付き箇条書きのパッケージ
\usepackage{graphicx} % 画像の挿入、テキストや図の操作のためのパッケージ
\usepackage{amssymb, amsmath} % 高度な数式記述用パッケージ
\usepackage{mathtools} % 高度な数式記述用パッケージ
\usepackage{tgtermes} % 欧文、数式のフォントをtimes系に
\usepackage[T1]{fontenc} % 欧文フォントを標準以外に
\usepackage{siunitx} % SI単位記法に準拠した形式で単位を書くためのパッケージ
\usepackage{indentfirst} % 最初の段落でインデントするためのパッケージ

\ifptex
    \ifnativeuptex
    %upLaTeX
        \usepackage[dvipdfmx,unicode,hidelinks,pdfusetitle]{hyperref} % ハイパーリンクをつけるためのパッケージ、unicodeの使用を許可、リンクの下線を消す、pdfのメタデータをタイトルにする
    \else
    %pLaTeX
    \fi
\fi

\ifluatex
    % LuaLaTeX
    \usepackage{luatexja}
    \usepackage[unicode,hidelinks,pdfusetitle,pdfversion=1.4]{hyperref} % ハイパーリンクをつけるためのパッケージ、unicodeの使用を許可、リンクの下線罫線を消す、pdfのメタデータをタイトルにする、pdfのバージョンを1.4にする
    \usepackage{hyperxmp} % PDFのメタデータを設定するためのパッケージ
\fi

\usepackage[backend=biber,style=numeric, sorting=none]{biblatex} % biblatexを使用するためのパッケージ
\addbibresource{references.bib}

% 参考文献の書式
% 日本語雑誌名を通常に、英語雑誌名を斜体に
\DeclareFieldFormat{journaltitle}{\textit{#1}}

% タイトルを通常に
\DeclareFieldFormat{title}{\textit{#1}}

% 参考文献リストの番号の後ろにスペースを入れる
\DeclareFieldFormat{labelnumberwidth}{\mkbibbrackets{#1}\hspace{.5\jlreq@zw}}

% yearを()で囲む
\DeclareFieldFormat[book,misc]{date}{\mkbibparens{#1}}

% article
% In.の削除
\renewbibmacro*{in:}{}

% 著者名と論文タイトルの間を:に変更
\DeclareDelimFormat[bib]{nametitledelim}{\addcolon\space}

% yearとpageの表示順を入れ替え
% \usebibmacro{issue+date}%をコメントアウトし、yearの表示を削除
\renewbibmacro*{journal+issuetitle}{%
    \usebibmacro{journal}%
    \setunit*{\addspace}%
    \iffieldundef{series}
        {}
        {\newunit
        \printfield{series}%
        \setunit{\addspace}}%
    \usebibmacro{volume+number+eid}%
    \setunit{\addspace}%
    % \usebibmacro{issue+date}%
    % \setunit{\addcolon\space}%
    \usebibmacro{issue}%
    \newunit}

% note+pagesにissue+dateを追加し、yearの表示を追加
\renewbibmacro*{note+pages}{%
    \printfield{note}%
    \setunit{\bibpagespunct}%
    \printfield{pages}%
    \setunit{\addcomma\space}%
    \usebibmacro{issue+date}%
    \setunit{\addspace}% ここで区切りを変更
}

% 本文中の参考文献の書式
% 参考文献表示を右肩に変更
\let\citebrackets\mkbibparens
\renewcommand*{\citebrackets}[1]{\textsuperscript{[#1]}}

\DeclareCiteCommand{\cite}[\citebrackets]
    {\usebibmacro{prenote}}
    {\usebibmacro{citeindex}%
    \usebibmacro{cite}}
    {\multicitedelim}
    {\usebibmacro{postnote}}

%ページ数の書式
\pagestyle{empty}

% figとtableの余白の調整
% \setlength{\intextsep}{0pt}

% キャプションとサブキャプションの設定、fontは10pt
\captionsetup[figure]{labelsep=space, name=Fig., font=normalsize}
\captionsetup[subfigure]{labelsep=space, labelformat=simple, name=Fig., font=normalsize}
\renewcommand*{\thesubfigure}{(\alph{subfigure})}
\captionsetup[table]{labelsep=space, name=Table\ , font=normalsize}

% sectionのフォントサイズを11ptに変更
\RenewBlockHeading{section}{1}{font={\fontsize{12truept}{12truept}\selectfont\bfseries\raggedright}}
\RenewBlockHeading{subsection}{2}{font={\fontsize{11truept}{11truept}\selectfont\bfseries\raggedright}}
\RenewBlockHeading{subsubsection}{3}{font={\fontsize{10truept}{10truept}\selectfont\bfseries\raggedright}}

% セクション前後の空白の設定
\ModifyHeading{section}{before_space=5truept, after_space=2truept}
\ModifyHeading{subsection}{before_space=5truept, after_space=2truept}
\ModifyHeading{subsubsection}{before_space=5truept, after_space=2truept}
% \ModifyHeading{section}{lines=1}
% \ModifyHeading{subsection}{lines=1}
% \ModifyHeading{subsubsection}{lines=1}

% セクションが連続する際の行取りを設定
\SetBlockHeadingSpaces{
    {_section{*},_subsection{before_space=0truept, after_space=0truept}}
    {_subsection{*},_subsubsection{before_space=0truept, after_space=0truept}}
}

% タイトルの変数設定
\def\title#1{\gdef\@title{#1}}
\let\@title\@empty

% 著者名の変数設定
\def\name#1{\gdef\@name{#1}}
\let\@name\@empty

% 英語タイトルの変数設定
\def\etitle#1{\gdef\@etitle{#1}}
\let\@etitle\@empty

% 英語著者名の変数設定
\def\ename#1{\gdef\@ename{#1}}
\let\@ename\@empty

% アブストラクトの変数設定
\def\abst#1{\gdef\@abst{#1}}
\let\@abst\@empty

% タイトルの設定
\makeatletter
\renewcommand{\@maketitle}{\newpage
    \centering
    \vspace{12truept}

    % もしtitleが定義されているならtitleを表示
    \ifx\@title\@empty\else
        \fontsize{16truept}{32truept}\selectfont
        \@title
        \par
    \fi


    % もしnameが定義されているならnameを表示
    \ifx\@name\@empty\else
        \fontsize{12truept}{29truept}\selectfont
        \@name
        \par
    \fi

    % もしetitleが定義されているならetitleを表示
    \ifx\@etitle\@empty\else
        \fontsize{16truept}{34truept}\selectfont
        \begin{bfseries}
            \@etitle
        \end{bfseries}
        \par
    \fi

    % もしenameが定義されているならenameを表示
    \ifx\@ename\@empty\else
        \fontsize{12truept}{32truept}\selectfont
        \@ename
        \par
    \fi

    \vspace{8truept}

    % abstractの設定
    \begin{minipage}{160mm}
        \fontsize{9truept}{9truept}\selectfont
        Abstract: \@abst
    \end{minipage}
    \vspace{18truept}
}
\makeatother