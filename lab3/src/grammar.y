%{
#include <stdio.h>
#include <stdlib.h>
#include<string.h>

extern int yylineno;
int yylex(void);
int yyrestart(FILE*);
void yyerror(char const * msg);

typedef enum {
    LEFT,
    RIGHT
} Orientation;

typedef enum {
    FUNCTION,
    ASSIGN,
    BNOT,
    BOR,
    BAND,
    INDENTIFIER,
    ILIT,
    OPERATION
} NodeType;

typedef struct node_data {
    NodeType type;
} NodeData;

typedef struct node{
    NodeData node_data;
    struct node *left, *right;
} Node;

typedef struct list {
    Node node;
    struct list *next;
} List;

List* add_to_list(List *list, Node node);
Node* add_node(Node *node, NodeData node_data, Orientation orientation);
void print_tree(Node *root);
void print_list(List *list);

Node *root;
List *list_root = NULL;
List *current_list = NULL;
NodeData nodeData;
%}

%token TOK_LPARENT TOK_RPARENT TOK_COMMA TOK_BOR TOK_BAND TOK_IDENTIFIER TOK_ASSIGN TOK_BNOT TOK_ILIT TOK_ERROR;
%type exp

%%
input
: %empty
| input line
;

line
: exp
| exp '\n'
;

exp
: TOK_IDENTIFIER TOK_ASSIGN TOK_ILIT {
    root = NULL;
    nodeData.type = ASSIGN;
	add_node(NULL, nodeData, LEFT);

    nodeData.type = INDENTIFIER;
    add_node(root, nodeData, LEFT);

    nodeData.type = ILIT;
    add_node(root, nodeData, RIGHT);

    if(current_list == NULL)
    {
        current_list = add_to_list(list_root, *root);
    }
    else{
        current_list = add_to_list(current_list, *root);
    }
}
    
| TOK_IDENTIFIER TOK_LPARENT TOK_IDENTIFIER TOK_RPARENT {
    root = NULL;
    nodeData.type = FUNCTION;
	add_node(NULL, nodeData, LEFT);

    nodeData.type = INDENTIFIER;
    add_node(root, nodeData, LEFT);

    if(current_list == NULL)
    {
        current_list = add_to_list(list_root, *root);
    }
    else{
        current_list = add_to_list(current_list, *root);
    }
}
| TOK_ILIT TOK_BOR TOK_ILIT {
    root = NULL;
    nodeData.type = BOR;
	add_node(NULL, nodeData, BOR);

    nodeData.type = ILIT;
    add_node(root, nodeData, LEFT);

    nodeData.type = ILIT;
    add_node(root, nodeData, RIGHT);

    if(current_list == NULL)
    {
        current_list = add_to_list(list_root, *root);
    }
    else{
        current_list = add_to_list(current_list, *root);
    }
}
| TOK_ILIT TOK_BAND TOK_ILIT {
    root = NULL;
    nodeData.type = BAND;
	add_node(NULL, nodeData, BAND);

    nodeData.type = ILIT;
    add_node(root, nodeData, LEFT);

    nodeData.type = ILIT;
    add_node(root, nodeData, RIGHT);

    if(current_list == NULL)
    {
        current_list = add_to_list(list_root, *root);
    }
    else{
        current_list = add_to_list(current_list, *root);
    }
}
;

%%
void yyerror(char const * msg){
    printf("In line %d: %s\n", yylineno, msg);
    exit(1);
}



List* add_to_list(List *list, Node node) {
    List *cur = (List*)malloc(sizeof(List));

    cur->next = NULL;
    cur->node = node;

    if (list == NULL) list_root = cur;
    else {
        list->next = cur;
    }
    return cur;
}

Node* add_node(Node *node, NodeData node_data, Orientation orientation) {
    Node *ptr = (Node*)malloc(sizeof(Node));

    ptr->left = ptr->right = NULL;
    ptr->node_data = node_data;

    if(node == NULL) {
        root = ptr;
    } else {
        switch (orientation){
            case RIGHT: node->right = ptr; break;
            case LEFT: 
                
                node->left = ptr;
        }
    }

    return ptr;
}



const char *EnumStrings[] = { "FUNCTION", "ASSIGN", "BNOT", "BOR", "BAND", "INDENTIFIER", "ILIT", "OPERATION"};
const char *getTextForEnum( int enumVal )
{
  return EnumStrings[enumVal];
}

int tabs = 0;
void print_tree(Node *root) {
    if (root == NULL) return;
    tabs += 5;
    
    for (int i = 0; i < tabs; i++) printf(" ");
    printf("%s\n", getTextForEnum(root->node_data.type));
    
    
    print_tree(root->left);
    print_tree(root->right);
    tabs -= 5;
    return;
}

void print_list(List *list) {
    if (list == NULL) return;
    printf("\nLINE\n");
    print_tree(&list->node);
    print_list(list->next);
}


int main(int argc, char **argv)
{
    

    FILE *file = fopen(argv[1],"r");
    if (file) {
        yyrestart(file);
        yyparse();
    } else {
        yyparse();
    }



    


    print_list(list_root);

    return 0;
}