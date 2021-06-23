%{
    #include "main.h"
    #include "lex.yy.h"
%}


%union{
    char* strv;
}

%token <strv> KTYPENUMBER KTYPESTRING KIF KELSE KWHILE 
%token <strv> OPALGORLOW OPALGORHIGH OPATTACHVAL OPLOGALGOR OPOR OPAND OPSOP OPLB OPRB OPLBB OPRBB OPSEMI OPCOMMA
%token <strv> NUMBER STRING NAME
%type   Program FullDefineList VariableDefine FunctionDefine VariableDefineList FunctionDefineList FunctionDescription ParamList
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
%%

Program:
    |FullDefineList
    ;
FullDefineList:
    FunctionDefineList
    |VariableDefineList FunctionDefineList
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
    |
    ;
Statement:
    CodeBlock
    |KIF OPLB Expressions OPRB Statement
    |KIF OPLB Expressions OPRB Statement KELSE Statement
    |KWHILE OPLB Expressions OPRB Statement
    ;

VariableDefineList:
    VariableDefine VariableDefineList
    |VariableDefine
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
