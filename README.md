# [The Haxe Manual](https://haxe.org/manual)

[![Build Status](https://travis-ci.org/HaxeFoundation/HaxeManual.svg?branch=master)](https://travis-ci.org/HaxeFoundation/HaxeManual)

Contributions / Information for authors
-------------

**For contributions please edit the _.tex_ files in in [HaxeManual/](HaxeManual/).  The _.md_ files are generated from it.**

The manual is structured using these commands:  
`\chapter{name}`, `\section{name}`, `\subsection{name}`, `\paragraph{name}`
> Chapter, section and subsection require a `\label{id}` so a URL can be determined. It should not contain any spaces.

Formatting:  
* Bold text: `\emph{Emphasized text}`
* Code: `\expr{haxe code}`, `\type{MyClass}`, `\ic{other code}`
* Since: `\since{3.1.0}`
* Definition blockquote: `\define{Definition name}{define-definition}{Definition description}`
* Trivia blockquote: `\trivia{About Trivia}{This is trivia}`
* Internal Links: `\tref{Link name}{chapter-section-id}` or `\Fullref{chapter-section-id}`
* External Links: `\href{https://haxe.org}{Haxe Website}`

Block of [external code](HaxeManual/assets) (preferred since those are tested):  
```tex
\haxe{assets/Color.hx}
```
Block of code:  
```tex
\begin{lstlisting}
trace("Haxe is great!");
\end{lstlisting}
```
Unordered list:
```tex
\begin{itemize}
	\item What is your name?
	\item How old are you?
\end{itemize}
```
Definition list:
```tex
\begin{description}
	\item[Coffee] Black hot drink
	\item[Milk] White cold drink
\end{description}
```

Finally, if you want to contribute to the Haxe Manual but cannot be arsed to use _.tex_, just write it in any other format and we'll port it.

---

Generating Markdown
-----------------

Run [convert/convert.hxml](convert/convert.hxml) to generate the markdown which will be exported to the [output-folder](output/). For quick testing disable the .mobi generation.

You can use the following defines when using `convert` for additional features.

- `-D compileEnv`
Generates images from custom LaTeX environments too complex for Markdown (specifically the `flowchart` environment at the time of writing). Skips already existing images.
- `-D recompileEnv`
Generates images even if they already exist at their destination (most useful for `convert` development).
- `-D keepEnvPDF`
Keeps the LaTeX generated PDF files. They're placed next to generated images with the same name.
- `-D keepEnvTemp`
Keeps the generated temporary directory for LaTeX compilation. Useful for debugging / development purposes.


PDF generation
--------------

To rebuild the .pdf from the command line, run `latexmk -xelatex HaxeDoc.tex`.
A recent version of [TeX Live] should provide latexmk and all needed packages
and their dependencies:

 - xelatex
 - cleveref
 - courier
 - framed
 - fullpage
 - geometry
 - graphicx
 - hyperref
 - listings
 - palatino
 - tikz, tkz-euclide, tkz-qtree
 - todonotes
 - underscore
 - xcolor


Requirements for `compileEnv`
-----------------------------

At the time of writing, `compileEnv` depends on the following.

- `xelatex` being in path. [TeX Live] 2013 version should be sufficient. Used to compile custom LaTeX environment snippets to PDF.
- `mudraw` being in path. This is a part of [MuPDF]. Used for rendering PDF to a PNG image.
- `pandoc` being in path. Used for generating *.epub* file.
- `ebook-convert` being in path. This is a part of [calibre]. Used for converting *.epub* to *.mobi*.
- [Source Sans Pro] and [Source Code Pro] fonts being installed.


[TeX Live]:http://www.tug.org/texlive/
[MuPDF]:http://www.mupdf.com/
[calibre]:http://calibre-ebook.com/
[Source Sans Pro]:http://sourceforge.net/projects/sourcesans.adobe/
[Source Code Pro]:http://sourceforge.net/projects/sourcecodepro.adobe/

