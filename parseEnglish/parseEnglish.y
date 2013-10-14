%{
/*
Inspired from Lex and Yacc -Oreilly
*/
#include <stdio.h>

%}

%token NOUN PRONOUN VERB 

%% 
sentence: subject VERB object {printf ("Sentence is valid. \n");} 	

subject: NOUN | PRONOUN ;
object: NOUN ;

%%

extern FILE *yyin ;

main()
{
while (!feof(yyin)) {
	yyparse();
}
}

yyerror(s)
char *s;
{
	fprintf (stderr, "%s\n",s);
}
