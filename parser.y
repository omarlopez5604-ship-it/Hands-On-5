%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
void yyerror(const char *s);

#define MAX_VARS 100

typedef struct {
    char* name;
    int value;
} variable;

variable symtab[MAX_VARS];
int var_count = 0;

int get_value(char* name);
void set_value(char* name, int value);
%}

%union {
    int num;
    char* id;
}

%token <num> NUM
%token <id> ID
%token PRINT
%token PLUS MINUS MUL DIV ASSIGN SEMICOLON

%type <num> expr

%%

program:
    program statement
    | statement
;

statement:
    ID ASSIGN expr SEMICOLON
        { set_value($1, $3); }
    | PRINT expr SEMICOLON
        { printf("Resultado: %d\n", $2); }
;

expr:
    expr PLUS expr   { $$ = $1 + $3; }
    | expr MINUS expr { $$ = $1 - $3; }
    | expr MUL expr   { $$ = $1 * $3; }
    | expr DIV expr   { $$ = $1 / $3; }
    | NUM             { $$ = $1; }
    | ID              { $$ = get_value($1); }
;

%%

int get_value(char* name) {
    for (int i = 0; i < var_count; i++) {
        if (strcmp(symtab[i].name, name) == 0)
            return symtab[i].value;
    }
    printf("Error: variable '%s' no definida\n", name);
    return 0;
}

void set_value(char* name, int value) {
    for (int i = 0; i < var_count; i++) {
        if (strcmp(symtab[i].name, name) == 0) {
            symtab[i].value = value;
            return;
        }
    }
    symtab[var_count].name = strdup(name);
    symtab[var_count].value = value;
    var_count++;
}

void yyerror(const char *s) {
    printf("Error sintáctico: %s\n", s);
}

int main() {
    printf("Mini compilador (ingresa código):\n");
    yyparse();
    return 0;
}