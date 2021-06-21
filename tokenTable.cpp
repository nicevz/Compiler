#include "tokenTable.h"
#include "lex.yy.h"

string _snodeType[] = {"Name", "Number", "String"};
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
int createNode(tableNode *&tn, _nodeType nt, string st)
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
int isExist(tableNode *tn, string st)
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
/**
 * @brief 打印表项
 * 
 * @param fn 表起始节点
 */
void printTable(tableNode *fn)
{
    while (fn != NULL)
    {
        cout << _snodeType[fn->nodeType] << "\t\t\t" << fn->nodeNo << "\t\t\t" << fn->content << endl;
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
void printError(string sl, int li, int ic)
{
    cerr << "Error: mystery character at line " << li << ":\n"
         << sl << endl;
    for (int i = ic; i > 0; --i)
    {
        cerr << " ";
    }
    cerr << "\\__ here" << endl;
    return;
}
/**
 * @brief 
 * 
 * @param argc 
 * @param argv 
 * @return int 
 */
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
    FlexLexer *lexer = new yyFlexLexer(fd);
    while (lexer->yylex() != 0)
        ;
    cout << resetiosflags(ios::left);
    cout << "=====================================================" << endl;
    cout << "Type\t\t\tNo.\t\t\tContent" << endl;
    printTable(firstNameNode->nextNode);
    cout << endl;
    printTable(firstNumberNode->nextNode);
    cout << endl;
    printTable(firstStringNode->nextNode);
    cout << "Total lines in file: " << myLineNo << endl;
    delete lexer;
    return 0;
}