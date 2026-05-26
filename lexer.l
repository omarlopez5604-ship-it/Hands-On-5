%{
#include "parser.tab.h"
#include <stdlib.h>
#include <string.h>
%}

%%

"print"              { return PRINT; }

[0-9]+               { yylval.num = atoi(yytext); return NUM; }

[a-zA-Z]+            { yylval.id = strdup(yytext); return ID; }

"+"                  { return PLUS; }
"-"                  { return MINUS; }
"*"                  { return MUL; }
"/"                  { return DIV; }
"="                  { return ASSIGN; }
";"                  { return SEMICOLON; }

[ \t\n]+             ;   // ignorar espacios

.                    { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
