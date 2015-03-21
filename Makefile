root = HaxeDoc

pdf: $(root).pdf PHONY

md: PHONY
	cd convert && haxe convert.hxml

$(root).pdf: PHONY
	latexmk -xelatex $(root).tex

clean: PHONY
	latexmk -c -xelatex $(root).tex
	rm -f convert/convert.n

dist-clean: clean
	git clean -f -- md/manual
	git checkout -- $(root).pdf md/manual todo.txt

.PHONY: PHONY

