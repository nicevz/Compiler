#include <iomanip>
#include "main.h"
#include "lex.yy.h"
#include "BisonLALR.tab.hh"

std::string _snodeType[] = {"Name", "Number", "String"};
int myLineNo;
tableNode *firstNameNode;   //初始化标识符头节点并分配空间
tableNode *firstNumberNode; //初始化整型常量头节点并分配空间
tableNode *firstStringNode; //初始化字符串常量头节点并分配空间

tableNode *currentNameNode;   //初始化标识符当前节点位置
tableNode *currentNumberNode; //初始化整型常量当前节点位置
tableNode *currentStringNode; //初始化字符串常量当前节点位置

/**
 * @brief 创建表项
 * 
 * @param tn 当前节点
 * @param nt 节点类型
 * @param st 节点内容
 * @return int 节点编号
 */
int createNode(tableNode *&tn, _nodeType nt, std::string st)
{
    int nodeNo = 0;
    tableNode *newNode = new tableNode;
    newNode->nodeNo = tn->nodeNo + 1;
    nodeNo = newNode->nodeNo;
    newNode->nodeType = nt;
    newNode->content = st;
    newNode->nextNode = NULL;
    tn->nextNode = newNode;
    tn = newNode;
    return nodeNo;
}
/**
 * @brief 检查重复节点
 * 
 * @param tn 起始节点
 * @param st 内容
 * @return int 节点编号
 */
int isExist(tableNode *tn, std::string st)
{
    while (tn != NULL)
    {
        if (tn->content == st)
        {
            return tn->nodeNo;
        }
        tn = tn->nextNode;
    }
    return -1;
}
int verifiedADD(std::string content, int type)
{
    if (type == 1)
    {
        int nodeNo = isExist(firstNumberNode, content);
        if (nodeNo == -1)
        {
            nodeNo = createNode(currentNumberNode, tnumber, content);
        }
        return nodeNo;
    }
    else if (type == 2)
    {
        int nodeNo = isExist(firstStringNode, content);
        if (nodeNo == -1)
        {
            nodeNo = createNode(currentStringNode, tstring, content);
        }
        return nodeNo;
    }
    else if (type == 3)
    {
        int nodeNo = isExist(firstNameNode, content);
        if (nodeNo == -1)
        {
            nodeNo = createNode(currentNameNode, tname, content);
        }
        return nodeNo;
    }
    else
    {
        throw std::runtime_error("error");
    }
}
/**
 * @brief 打印表项
 * 
 * @param fn 表起始节点
 */
void printTable(tableNode *fn)
{
    while (fn != NULL)
    {
        std::cout << _snodeType[fn->nodeType] << "\t\t\t" << fn->nodeNo << "\t\t\t" << fn->content << std::endl;
        fn = fn->nextNode;
    }
}
/**
 * @brief 打印错误
 * 
 * @param sl 行内容
 * @param li 行号
 * @param ic 列号
 */
void printError(std::string sl, int li, int ic)
{
    std::cerr << "Error: mystery character at line " << li << ":\n"
              << sl << std::endl;
    for (int i = ic; i > 0; --i)
    {
        std::cerr << " ";
    }
    std::cerr << "\\__ here" << std::endl;
    return;
}

void printLabel(std::string description, std::string content)
{
    std::cout << std::setiosflags(std::ios::left) << std::setw(36);
    std::cout << description << content << std::endl;
}

void printLabelNNS(std::string description, int nodenumber)
{
    std::cout << std::setiosflags(std::ios::left) << std::setw(36);
    std::cout << description << "*(" << nodenumber << ")" << std::endl;
}

void yyerror(const char *msg)
{
    std::cerr << msg << " at line " << yylineno << std::endl;
}

int main(int argc, char **argv)
{
    firstNameNode = new tableNode;
    firstNumberNode = new tableNode;
    firstStringNode = new tableNode;
    currentNameNode = firstNameNode;
    currentNumberNode = firstNumberNode;
    currentStringNode = firstStringNode;

    myLineNo = 0; //文件行数

    FILE *fd = stdin;
    if (argc > 1 && (fd = fopen(argv[1], "r")) == NULL)
    {
        exit(EXIT_FAILURE);
    }
    yyparse();

    std::cout << std::resetiosflags(std::ios::left);
    std::cout << "=====================================================" << std::endl;
    std::cout << "Type\t\t\tNo.\t\t\tContent" << std::endl;
    printTable(firstNameNode->nextNode);
    std::cout << std::endl;
    printTable(firstNumberNode->nextNode);
    std::cout << std::endl;
    printTable(firstStringNode->nextNode);
    std::cout << "Total lines in file: " << myLineNo << std::endl;
    return 0;
}