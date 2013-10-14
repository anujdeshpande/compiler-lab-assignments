%{
/*

5. Write lex and yacc program for parsing English statements.
Credits to Lex and Yacc - Oreilly

*/

#include "y.tab.h"
#include <string.h>
#include <stdlib.h>

int state;
int add_word(int type, char *word);
int lookup_word(char *word);

enum {LOOKUP=0,V,N,P};

struct word{
	char *word_name;
	int word_type;
	struct word *next;
};
struct word *wordlist;


%}

%%

[\n]	{state = LOOKUP;}
^verb	{state = V;}
^noun	{state = N;}
^pron 	{state = P;}

[a-zA-Z]+ {
		if(state!=LOOKUP)
			add_word(state,yytext);
		else
		{
		switch (lookup_word(yytext))
			{
			case V:
				return VE;break;
			case N:
				return NO;break;
			case P:
				return PR;break;
			default:
				printf("%s: doesn't exist in vocab\n",yytext);break;
			
			}
		}
	}	

%%

extern void *malloc();

int add_word(int type, char *word)
{

	struct word *wp;
	if(lookup_word(word) != LOOKUP) {
	printf(" Word %s is already defined \n",word);
	return 0;
	}
	wp = (struct word *)malloc(sizeof(struct word));
	wp->next = wordlist ;
	wp->word_name = (char*) malloc (strlen(word)+1);
	strcpy(wp->word_name, word);
	wp->word_type = type ;
	wordlist = wp;
	return 1;
}

int lookup_word( char *word)
{
	struct word *wp = wordlist; 
	for (;wp;wp=wp->next){
	if(strcmp(wp->word_name, word) == 0)
		return wp->word_type;
	}
	return LOOKUP;
}	

int yywrap ()
{
return 1 ;
}

