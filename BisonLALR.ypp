%{
    #include "main.h"
    #include "lex.yy.h"
%}


%union{
    char* strv;
}

%token <strv> KTYPEID KIF KELSE KWHILE 
%token <strv> OPALGORLOW OPALGORHIGH OPATTACHVAL OPLOGALGOR OPOR OPAND OPSOP OPLB OPRB OPLBB OPRBB OPCOL
%token <strv> NUMBER STRING NAME
%type Program Statement

%right OPATTACHVAL
%left OPOR
%left OPAND
%left OPLOGALGOR
%left OPALGORLOW
%left OPALGORHIGH
%right OPSOP
%left OPLB OPRB
%%
Program:|Statement;
Statement:KTYPEID NAME OPATTACHVAL NUMBER OPCOL;
%%
