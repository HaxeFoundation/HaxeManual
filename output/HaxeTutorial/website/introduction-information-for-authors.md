## Information for authors

Each article should be placed in a directory under /HaxeTutorials. The directory name should start with the difficulty level (Beginner, Intermediate, Advanced) and not contain any spaces (we recommend using dashes instead). Within this directory the author has free reign, but we recommend to have a single entry-point .tex file so it can easily be included in HaxeTutorials.tex.

Each article has to start with three self-explanatory commands:

* \article{name}
* \label{label}
* \maintainer{author name}

Note that the label is what is used for the URL of the article so it should not contain any spaces.

The document can be structured using these commands:

* \section*{name}
* \subsection*{name}
* \paragraph{name}

The asterisk is necessary to suppress section numbering. Furthermore, both section and subsection require a label so a URL can be determined.

Finally, if you want to write an article but cannot be arsed to use .tex, just write it in any other format and we'll port it.

---

Previous section: [About this document](introduction-about-this-document.md)

Next section: [Hello World](hello-world.md)