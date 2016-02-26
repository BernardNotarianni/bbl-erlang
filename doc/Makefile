UML_EPS := $(patsubst %.uml,%.eps,$(wildcard *.uml)) 

pdf: bbl.tex $(UML_EPS)
	pdflatex -halt-on-error -shell-escape  bbl.tex
	mv bbl.pdf slides.pdf	
	pdflatex -shell-escape "\def\isnotes{1} \input{bbl.tex}" 
	mv bbl.pdf notes.pdf

%.eps: %.uml
	java -jar ~/Downloads/plantuml.jar -teps $<

