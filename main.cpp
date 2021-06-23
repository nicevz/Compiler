#include "Node.h"
#include <iostream>
#include <iomanip>
#include "lex.yy.h"
#include "BisonLALR.tab.hh"

extern tableNode *firstNameNode;   //初始化标识符头节点并分配空间
extern tableNode *firstNumberNode; //初始化整型常量头节点并分配空间
extern tableNode *firstStringNode; //初始化字符串常量头节点并分配空间

extern tableNode *currentNameNode;   //初始化标识符当前节点位置
extern tableNode *currentNumberNode; //初始化整型常量当前节点位置
extern tableNode *currentStringNode; //初始化字符串常量当前节点位置

int main(int argc, char **argv)
{
    firstNameNode = new tableNode;
    firstNumberNode = new tableNode;
    firstStringNode = new tableNode;
    currentNameNode = firstNameNode;
    currentNumberNode = firstNumberNode;
    currentStringNode = firstStringNode;

    FILE *fd = stdin;
    if (argc > 1 && (fd = fopen(argv[1], "r")) == NULL)
    {
        exit(EXIT_FAILURE);
    }

    yyscanner_t scanner; // new way in C++ using reflex-generated yyscanner_t
    yyparse(&scanner);   // scanner is passed on to yylex()

    std::cout << std::resetiosflags(std::ios::left);
    std::cout << "=====================================================" << std::endl;
    std::cout << "Type\t\t\tNo.\t\t\tContent" << std::endl;
    printTable(firstNameNode->nextNode);
    std::cout << std::endl;
    printTable(firstNumberNode->nextNode);
    std::cout << std::endl;
    printTable(firstStringNode->nextNode);
    return 0;
}