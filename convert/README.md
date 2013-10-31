TeX to MarkDown Converter
========================

This haxe program parses the contents of *HaxeDoc.tex* and generates markdown (*.md*) files for the different sections.  The *.md* files live in:

`../md/manual`

The *.md* files are broken out and named by subsection and title 

Generating markdown
-------------------

make sure the library hxparse is installed. If not:

`haxelib install hxparse`

then just run the .hxml file

`haxe convert.hxml`
