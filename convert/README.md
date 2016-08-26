TeX to MarkDown Converter
========================

This haxe program parses the contents of *HaxeDoc.tex* and generates MarkDown (*.md*) files for the different sections.  The *.md* files live in:

`../md/manual`

The *.md* files are broken out and named by subsection and title 

Generating MarkDown
-------------------

make sure the library hxparse is installed. If not:

`haxelib install hxparse`

then just run the .hxml file

`haxe convert.hxml`

Exception... No Match:
---------

Most common LaTeX commands are correctly parsed, but the list is not exhaustive.  To add a new LaTeX command:

if it is a custom (i.e. not standard) LaTeX command:
1. Add it as a `CustomCommand` in LatexParser.hx --There are plenty of examples in the file.

If it is a standard LaTeX command:
1. Add the command to the enum in *LatexCommand.hx*
2. Add the functionality to the appropriate switch in *LatexParser.hx*


