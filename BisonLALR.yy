%{
    #include "lex.yy.h"
    void yyerror(YYLTYPE*, yyscan_t, const char*);
    /* Pass the parameter 'scanner' to yyparse through to yylex. */
    #define YYPARSE_PARAM scanner
    #define YYLEX_PARAM   scanner
%}

%locations
%pure-parser
%lex-param { void *scanner }
%parse-param { void *scanner }

%union{
    char* strv;
}

%token <strv> KTYPENUMBER KTYPESTRING KIF KELSE KWHILE 
%token <strv> OPALGORLOW OPALGORHIGH OPATTACHVAL OPLOGALGOR OPOR OPAND OPSOP OPLB OPRB OPLBB OPRBB OPSEMI OPCOMMA
%token <strv> NUMBER STRING NAME
%type   Program VariableDefine FunctionDefine VariableDefineList FunctionDefineList FunctionDescription ParamList
%type   CodeBlock StatementList Statement 
%type   NumberDescriptionList NumberDescription StringDescriptionList StringDescription AssignNumber AssignString
%type   Expressions Arguments

%left OPCOMMA
%right OPATTACHVAL
%left OPOR
%left OPAND
%left OPLOGALGOR
%left OPALGORLOW
%left OPALGORHIGH
%right OPSOP
%left OPLB OPRB
%nonassoc LOWER_THAN_ELSE
%nonassoc KELSE
%%

Program:
    %empty
    |FunctionDefineList
    ;
FunctionDefineList:
    FunctionDefine FunctionDefineList
    |FunctionDefine
    ;
FunctionDefine:
    KTYPENUMBER FunctionDescription CodeBlock
    |KTYPESTRING FunctionDescription CodeBlock
    ;
FunctionDescription:
    NAME OPLB ParamList OPRB
    |NAME OPLB OPRB
    ;
ParamList:
    KTYPENUMBER NAME OPCOMMA ParamList
    |KTYPENUMBER NAME
    |KTYPESTRING NAME OPCOMMA ParamList
    |KTYPESTRING NAME
    ;

CodeBlock:
    OPLBB VariableDefineList StatementList OPRBB
    |OPLBB StatementList OPRBB
    ;
StatementList:
    Statement StatementList
    |%empty
    ;
Statement:
    Expressions OPSEMI
    |CodeBlock
    |KIF OPLB Expressions OPRB Statement                %prec LOWER_THAN_ELSE
    |KIF OPLB Expressions OPRB Statement KELSE Statement
    |KWHILE OPLB Expressions OPRB Statement
    ;

VariableDefineList:
    VariableDefine
    |VariableDefine VariableDefineList
    ;
VariableDefine:
    KTYPENUMBER NumberDescriptionList OPSEMI
    |KTYPESTRING StringDescriptionList OPSEMI
    ;
NumberDescriptionList:
    NumberDescription
    |NumberDescription OPCOMMA NumberDescriptionList
    ;
NumberDescription:
    NAME
    |AssignNumber
    ;
AssignNumber:
    NAME OPATTACHVAL Expressions
    ;
StringDescriptionList:
    StringDescription
    |StringDescription OPCOMMA StringDescriptionList
    ;
StringDescription:
    NAME
    |AssignString
    ;
AssignString:
    NAME OPATTACHVAL STRING
    ;

Expressions:
    Expressions OPATTACHVAL Expressions
    |Expressions OPAND Expressions
    |Expressions OPOR Expressions
    |Expressions OPLOGALGOR Expressions
    |Expressions OPALGORLOW Expressions
    |Expressions OPALGORHIGH Expressions
    |OPLB Expressions OPRB
    |OPSOP Expressions
    |Expressions OPSOP
    |NAME OPLB Arguments OPRB
    |NAME OPLB OPRB
    |NAME
    |NUMBER
    |STRING
    ;
Arguments:
    Expressions OPCOMMA Arguments
    |Expressions
    ;

%%
void yyerror(YYLTYPE *yylloc, yyscan_t scanner, const char *msg)
{
  (void)scanner; // appease -Wall -Werror
  std::cerr << msg << " at " << yylloc->first_line << "," << yylloc->first_column << std::endl;
}
