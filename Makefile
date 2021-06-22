result:BisonLALR.yy LexicalAnalyzer.l main.h color.hpp
	bison -d BisonLALR.yy
	reflex LexicalAnalyzer.l
	g++ lex.yy.cpp main.cpp BisonLALR.tab.cc ./libreflex.a -g
