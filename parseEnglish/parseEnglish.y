%{
/*
*Inspired from Lex and Yacc -Oreilly
*/

#include <stdio.h>
#include <stdlib.h>	

%}

%token VE NO PR 

%% 

sentence : subject VE object {printf ("\nSentence is valid\n");} 
	;

subject	: NO 
	  | 
	  PR 
	  ;

object	: NO 
	  ;

%%

int main()
{
	yyparse();
	return 0;
}

int yyerror()
{
printf("Error\n");
return 0;
}
