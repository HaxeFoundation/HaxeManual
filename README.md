HaxeManual
==========

[![Build Status](https://travis-ci.org/HaxeFoundation/HaxeManual.png)](https://travis-ci.org/HaxeFoundation/HaxeManual)

For contributions please edit the .tex file.  The .md files are generated from it.

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


Markdown generation
-------------------

You can use the following defines when using `convert` for additional features.

- `-D compileEnv`
Generates images from custom LaTeX environments too complex for Markdown (specifically the `flowchart` environment at the time of writing). Skips already existing images.
- `-D recompileEnv`
Generates images even if they already exist at their destination (most useful for `convert` development).
- `-D keepEnvPDF`
Keeps the LaTeX generated PDF files. They're placed next to generated images with the same name.
- `-D keepEnvTemp`
Keeps the generated temporary directory for LaTeX compilation. Useful for debugging / development purposes.


Requirements for `compileEnv`
-----------------------------

At the time of writing, `compileEnv` depends on the following.

- `xelatex` being in path. [TeX Live] 2013 version should be sufficient. Used to compile custom LaTeX environment snippets to PDF.
- `mudraw` being in path. This is a part of [MuPDF]. Used for rendering PDF to a PNG image.
- [Source Sans Pro] and [Source Code Pro] fonts being installed.


[TeX Live]:http://www.tug.org/texlive/
[MuPDF]:http://www.mupdf.com/
[Source Sans Pro]:http://sourceforge.net/projects/sourcesans.adobe/
[Source Code Pro]:http://sourceforge.net/projects/sourcecodepro.adobe/

