result:BisonLALR.yxx LexicalAnalyzer.l main.h color.hpp
	bison -d BisonLALR.yxx
	reflex LexicalAnalyzer.l
	g++ lex.yy.cpp main.cpp BisonLALR.tab.cxx ./libreflex.a -g
