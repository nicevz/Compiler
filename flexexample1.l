%{
  #include "tokenTable.h"
  extern int myLineNo;
  extern tableNode *firstNameNode;   //初始化标识符头节点并分配空间
  extern tableNode *firstNumberNode; //初始化整型常量头节点并分配空间
  extern tableNode *firstStringNode; //初始化字符串常量头节点并分配空间
  extern tableNode *currentNameNode;   //初始化标识符当前节点位置
  extern tableNode *currentNumberNode; //初始化整型常量当前节点位置
  extern tableNode *currentStringNode; //初始化字符串常量当前节点位置
%}

%option noyywrap graphs_file yylineno header_file flex bison
/* 处理关键字 */
ktypei (int)
ktypef (float)
ktypes (string)
KTYPEID {ktypei}|{ktypef}|{ktypes}

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
OPCOL ;
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

{KTYPEID}  {
  string tmp=YYText();
  cout << setiosflags(ios::left)<< setw(36);
  cout<<BOLD("Type identifier: ")<<tmp<<endl;
  yylval.strv = strdup(tmp.c_str());
  return KTYPEID;
}
{KIF} {
  string tmp=YYText();
  cout << setiosflags(ios::left)<< setw(36);
  cout<<FLCY("Keyword: ")<<tmp<<endl;
    yylval.strv = strdup(tmp.c_str());
  return KIF;
}
{KELSE} {
    string tmp=YYText();
  cout << setiosflags(ios::left)<< setw(36);
  cout<<FLCY("Keyword: ")<<tmp<<endl;
    yylval.strv = strdup(tmp.c_str());
  return KELSE;
}
{KWHILE} {
    string tmp=YYText();
  cout << setiosflags(ios::left)<< setw(36);
  cout<<FLCY("Keyword: ")<<tmp<<endl;
    yylval.strv = strdup(tmp.c_str());
  return KWHILE;
}

{OPALGORLOW} {
    string tmp=YYText();
  cout << setiosflags(ios::left)<< setw(36);
  cout<<FLMG("Algorithm operator: ")<<tmp<<endl;
    yylval.strv = strdup(tmp.c_str());
  return OPALGORLOW;
}
{OPALGORHIGH} {
    string tmp=YYText();
  cout << setiosflags(ios::left)<< setw(36);
  cout<<FLMG("Algorithm operator: ")<<tmp<<endl;
    yylval.strv = strdup(tmp.c_str());
  return OPALGORHIGH;
}
{OPATTACHVAL} {
    string tmp=YYText();
  cout << setiosflags(ios::left)<< setw(36);
  cout<<FLRD("Attach value operator: ")<<tmp<<endl;
    yylval.strv = strdup(tmp.c_str());
  return OPATTACHVAL;
}
{OPLOGALGOR} {
    string tmp=YYText();
  cout << setiosflags(ios::left)<< setw(36);
  cout<<FLGR("Logical operator: ")<<tmp<<endl;
    yylval.strv = strdup(tmp.c_str());
  return OPLOGALGOR;
}
{OPOR}  {
  string tmp=YYText();
  cout << setiosflags(ios::left)<< setw(36);
  cout<<FLGR("Logical operator: ")<<tmp<<endl;
    yylval.strv = strdup(tmp.c_str());
  return OPOR;
}
{OPAND} {
  string tmp=YYText();
  cout << setiosflags(ios::left)<< setw(36);
  cout<<FLGR("Logical operator: ")<<tmp<<endl;
    yylval.strv = strdup(tmp.c_str());
  return OPAND;
}
{OPSOP} {
    string tmp=YYText();
  cout << setiosflags(ios::left)<< setw(36);
  cout<<FLYE("Self operator: ")<<tmp<<endl;
    yylval.strv = strdup(tmp.c_str());
  return OPSOP;
}

{OPLB} {
    string tmp=YYText();
  cout << setiosflags(ios::left)<< setw(36);
  cout<<"Left bracket: "<<tmp<<endl;
    yylval.strv = strdup(tmp.c_str());
  return OPLB;
}
{OPRB} {
    string tmp=YYText();
  cout << setiosflags(ios::left)<< setw(36);
  cout<<"Right bracket: "<<tmp<<endl;
    yylval.strv = strdup(tmp.c_str());
  return OPRB;
}
{OPLBB} {
    string tmp=YYText();
  cout << setiosflags(ios::left)<< setw(36);
  cout<<"Left brace: "<<tmp<<endl;
    yylval.strv = strdup(tmp.c_str());
  return OPLBB;
}
{OPRBB} {
    string tmp=YYText();
  cout << setiosflags(ios::left)<< setw(36);
  cout<<"Right brace: "<<tmp<<endl;
    yylval.strv = strdup(tmp.c_str());
  return OPRBB;
}
{OPCOL} {
    string tmp=YYText();
  cout << setiosflags(ios::left)<< setw(36);
  cout<<FLBL("Colon: ")<<tmp<<endl;
    yylval.strv = strdup(tmp.c_str());
  return OPCOL;
}


{NUMBER}  {
  string tmp=YYText();
  cout << setiosflags(ios::left)<< setw(36);
  int nodeNo=isExist(firstNumberNode,tmp);
  if(nodeNo==-1){
    nodeNo=createNode(currentNumberNode,tnumber,tmp);
  }
  cout<<FGRN("Number: ")<<"*("<<nodeNo<<")"<<endl;
    yylval.strv = strdup(tmp.c_str());
  return NUMBER;
}
{STRING}  {
  string tmp=YYText();
  cout << setiosflags(ios::left)<< setw(36);
  int nodeNo=isExist(firstStringNode,tmp);
  if(nodeNo==-1){
    nodeNo=createNode(currentStringNode,tstring,tmp);
  }
  cout<<FYEL("String: ")<<"*("<<nodeNo<<")"<<endl;
    yylval.strv = strdup(tmp.c_str());
  return STRING;
}
{NAME}    {
  string tmp=YYText();
  cout << setiosflags(ios::left)<< setw(36);
  int nodeNo=isExist(firstNameNode,tmp);
  if(nodeNo==-1){
    nodeNo=createNode(currentNameNode,tname,tmp);
  }
  cout<<FCYN("Name: ")<<"*("<<nodeNo<<")"<<endl;
    yylval.strv = strdup(tmp.c_str());
  return NAME;
}

\n        {
  myLineNo++;
}

.         {
  printError(matcher().line(),yylineno,columno());
  return 0;
}
%%