HaxeManual
==========

For contributions please edit the .tex file (the .md files are generated from it).


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

- `xelatex` being in path. [TexLive](http://www.tug.org/texlive/) 2013 version should be sufficient. Used to compile custom LaTeX environment snippets to PDF.
- `mudraw` being in path. This is a part of [MuPDF](http://www.mupdf.com/). Used for rendering PDF to a PNG image.
- [Source Sans Pro](http://sourceforge.net/projects/sourcesans.adobe/) and [Source Code Pro](http://sourceforge.net/projects/sourcecodepro.adobe/) fonts being installed.