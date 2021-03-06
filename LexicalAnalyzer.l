%top{
  #include "BisonLALR.tab.hh"
  #include "Node.h"
}

%option bison-locations bison-bridge noyywrap header-file
/* 处理关键字 */

ktypei (int)
ktypef (float)
KTYPESTRING (string)
KTYPENUMBER {ktypei}|{ktypef}

KIF (if)
KELSE (else)
KWHILE (while)

/* 处理运算符 */

opplus \+
opminus -
opmultiply \*
opdivision \/
OPALGORLOW {opplus}|{opminus}
OPALGORHIGH {opdivision}|{opmultiply}

OPATTACHVAL =

opequ ==
opneq !=
opb >
opl <
opbe >=
ople <=
OPOR \|\|
OPAND &&
OPLOGALGOR {opequ}|{opneq}|{opb}|{opl}|{opbe}|{ople}

oppp \+\+
opmm --
OPSOP {oppp}|{opmm}

OPLB \(
OPRB \)
OPLBB \{
OPRBB \}
OPSEMI ;
OPCOMMA ,
/* 字符串类型 */
STRING  \"[^\n"]+\"
/* 空白符类型 */
ws      [ \t]+
/* 字母 */
alpha   [A-Za-z]
/* 数 */
dig     [0-9]
/* 关键字 */
NAME    ({alpha}|_)({alpha}|{dig}|[_.\-/$])*
/* 数字类型1 */
num1    [-+]?{dig}+\.?([eE][-+]?{dig}+)?
/* 数字类型2 */
num2    [-+]?{dig}*\.{dig}+([eE][-+]?{dig}+)?
/* 最终数 */
NUMBER  {num1}|{num2}

%%

/* 忽略空白符 */
{ws}

"/*"(.|\n)*?"*/"  /* no action: ignore multiline comments */
(?^^\h*"//".*)

{KTYPENUMBER}  {
  std::string tmp=YYText();
  printLabel(BOLD("NUMBER identifier: "),tmp);
  yylval.strv = strdup(tmp.c_str());
  return KTYPENUMBER;
}
{KTYPESTRING}  {
  std::string tmp=YYText();
  printLabel(BOLD("String identifier: "),tmp);
  yylval.strv = strdup(tmp.c_str());
  return KTYPESTRING;
}
{KIF} {
  std::string tmp=YYText();
  printLabel(FLCY("Keyword: "),tmp);
  yylval.strv = strdup(tmp.c_str());
  return KIF;
}
{KELSE} {
    std::string tmp=YYText();
    printLabel(FLCY("Keyword: "),tmp);
    yylval.strv = strdup(tmp.c_str());
    return KELSE;
}
{KWHILE} {
    std::string tmp=YYText();
    printLabel(FLCY("Keyword: "),tmp);
    yylval.strv = strdup(tmp.c_str());
    return KWHILE;
}

{OPALGORLOW} {
    std::string tmp=YYText();
    printLabel(FLMG("Algorithm operator: "),tmp);
    yylval.strv = strdup(tmp.c_str());
  return OPALGORLOW;
}
{OPALGORHIGH} {
    std::string tmp=YYText();
    printLabel(FLMG("Algorithm operator: "),tmp);
    yylval.strv = strdup(tmp.c_str());
  return OPALGORHIGH;
}
{OPATTACHVAL} {
    std::string tmp=YYText();
    printLabel(FLRD("Attach value operator: "),tmp);
    yylval.strv = strdup(tmp.c_str());
  return OPATTACHVAL;
}
{OPLOGALGOR} {
    std::string tmp=YYText();
    printLabel(FLGR("Logical operator: "),tmp);
    yylval.strv = strdup(tmp.c_str());
  return OPLOGALGOR;
}
{OPOR}  {
  std::string tmp=YYText();
    printLabel(FLGR("Logical operator: "),tmp);
    yylval.strv = strdup(tmp.c_str());
  return OPOR;
}
{OPAND} {
  std::string tmp=YYText();
    printLabel(FLGR("Logical operator: "),tmp);
    yylval.strv = strdup(tmp.c_str());
  return OPAND;
}
{OPSOP} {
    std::string tmp=YYText();
    printLabel(FLYE("Self operator: "),tmp);
    yylval.strv = strdup(tmp.c_str());
  return OPSOP;
}

{OPLB} {
    std::string tmp=YYText();
    printLabel("Left bracket: ",tmp);
    yylval.strv = strdup(tmp.c_str());
  return OPLB;
}
{OPRB} {
    std::string tmp=YYText();
    printLabel("Right bracket: ",tmp);
    yylval.strv = strdup(tmp.c_str());
  return OPRB;
}
{OPLBB} {
    std::string tmp=YYText();
    printLabel("Left brace: ",tmp);
    yylval.strv = strdup(tmp.c_str());
  return OPLBB;
}
{OPRBB} {
    std::string tmp=YYText();
    printLabel("Right brace: ",tmp);
    yylval.strv = strdup(tmp.c_str());
  return OPRBB;
}
{OPSEMI} {
    std::string tmp=YYText();
    printLabel(FLBL("Semicolon: "),tmp);
    yylval.strv = strdup(tmp.c_str());
  return OPSEMI;
}
{OPCOMMA} {
    std::string tmp=YYText();
    printLabel(FLBL("Comma: "),tmp);
    yylval.strv = strdup(tmp.c_str());
    return OPCOMMA;
}


{NUMBER}  {
  std::string tmp=YYText();
  printLabelNNS(FGRN("Number: "),verifiedADD(tmp,1));
  yylval.strv = strdup(tmp.c_str());
  return NUMBER;
}
{STRING}  {
  std::string tmp=YYText();
  printLabelNNS(FYEL("String: "),verifiedADD(tmp,2));
  yylval.strv = strdup(tmp.c_str());
  return STRING;
}
{NAME}    {
  std::string tmp=YYText();
  printLabelNNS(FCYN("Name: "),verifiedADD(tmp,3));
  yylval.strv = strdup(tmp.c_str());
  return NAME;
}

\n

.         {
  printError(matcher().line(),yylineno,columno());
  return 0;
}
%%