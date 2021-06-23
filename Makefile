result:BisonLALR.yy LexicalAnalyzer.l main.h color.hpp
	bison -d -g -v BisonLALR.yy
	reflex LexicalAnalyzer.l
	g++ lex.yy.cpp main.cpp BisonLALR.tab.cc ./libreflex.a -g
