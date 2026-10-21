LATEX = lualatex
export TEXINPUTS := .:content/tex/:

all: endofcp

endofcp: | build
	$(LATEX) -output-directory build content/endofcp.tex
	$(LATEX) -output-directory build content/endofcp.tex
	$(LATEX) -output-directory build content/endofcp.tex
	@echo "Built: build/endofcp.pdf"

build:
	mkdir -p build

clean:
	rm -rf build

.PHONY: all endofcp build clean
