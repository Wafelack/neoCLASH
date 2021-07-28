LC := latexmk
LFLAGS := -pdf
PDF := specification.pdf

$(PDF):
	$(LC) main.tex -pdf
	mv main.pdf $(PDF)
	$(LC) -c

preview: clean $(PDF)
	firefox $(PDF)

clean:
	$(LC) -C
	rm -f $(PDF)
.PHONY: clean

