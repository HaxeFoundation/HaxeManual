root = HaxeManual
dir:=HaxeManual/

pdf: $(dir)$(root).pdf PHONY

md: PHONY
	cd convert && haxe convert.hxml

$(dir)$(root).pdf: $(wildcard $(dir)*.tex)
	cd $(dir); latexmk -xelatex $(root).tex

clean: PHONY
	cd $(dir); latexmk -c -xelatex $(root).tex
	rm -f convert/convert.n

dist-clean: clean
	git clean -f -- output/$(root)
	git checkout -- $(dir)$(root).pdf output/$(root) $(dir)todo.txt

.PHONY: PHONY
