NAME = mh_theory
TYPE = pdf
OUTPUT = $(NAME).$(TYPE)

SRCOTHER = mh_theory.bib wileyj.bst nlaauth.cls 

all: $(OUTPUT)

%.ps: %.dvi
	dvips -Ppdf $< -o $@

#%.pdf: %.ps
#	ps2pdf $<

%.pdf: %.tex
	pdflatex $(basename $<)
	bibtex $(basename $<)
	pdflatex $(basename $<)
	pdflatex $(basename $<)

%.dvi: %.tex
	latex $(basename $<)
#	bibtex $(basename $<)
#	latex $(basename $<)
	latex $(basename $<)

# dependence on bibliography files
$(OUTPUT): $(SRCOTHER)

tar: $(OUTPUT)
	tar -cvf $(basename $<).tar results/*.png figs/*.pdf results/*.pdf $(basename $<).tex Makefile $(SRCOTHER)
	gzip $(basename $<).tar 

$(NAME)_2p.ps: $(NAME).ps
	psnup -2 $(NAME).ps $(NAME)_2p.ps

mac:    all
	open $(OUTPUT)

clean:
	rm -f *.log *.aux *.toc *.dvi *.bbl *.blg *.idx

veryclean: clean
	rm -f $(OUTPUT) 

