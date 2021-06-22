result:BisonLALR.ypp LexicalAnalyzer.l main.h
	bison -d BisonLALR.ypp
	reflex LexicalAnalyzer.l
	g++ lex.yy.cpp main.cpp BisonLALR.tab.cpp ./libreflex.a -g
