#ifndef GOUSHI
#define GOUSHI
#include <string>
#include "color.hpp"

enum _nodeType
{
    tname,
    tnumber,
    tstring
}; //表项类型
struct tableNode
{
    int nodeNo;          //表项编号
    _nodeType nodeType;  //表项类型
    std::string content; //表项内容
    tableNode *nextNode; //下一项
};
void yyerror(const char *msg);
int createNode(tableNode *&tn, _nodeType nt, std::string st);
int isExist(tableNode *tn, std::string st);
int verifiedADD(std::string content, int type);
void printError(std::string sl, int li, int ic);
void printLabel(std::string description, std::string content);
void printLabelNNS(std::string description, int nodenumber);
#endif