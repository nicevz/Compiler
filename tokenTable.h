#ifndef TT
#define TT
#include <string>
#include <iostream>
#include <iomanip>
#include "color.h"
using namespace std;
#include "bis.tab.hpp"

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
    string content;      //表项内容
    tableNode *nextNode; //下一项
};
int createNode(tableNode *&tn, _nodeType nt, string st);
int isExist(tableNode *tn, string st);
void printError(string sl, int li, int ic);
#endif