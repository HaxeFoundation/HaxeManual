root = HaxeDoc

pdf: $(root).pdf PHONY

$(root).pdf: PHONY
	latexmk -xelatex $(root).tex

clean: PHONY
	latexmk -c -xelatex $(root).tex

dist-clean: PHONY
	latexmk -C -xelatex $(root).tex

.PHONY: PHONY

