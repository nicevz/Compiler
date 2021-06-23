result:BisonLALR.yy LexicalAnalyzer.l main.cpp Node.h Node.cpp color.hpp
	bison -d -g -v BisonLALR.yy
	reflex --flex --bison-locations --bison-bridge --header-file --graphs_file LexicalAnalyzer.l
	g++ -O2 BisonLALR.tab.cc lex.yy.cpp Node.cpp main.cpp ./libreflex.a -g
