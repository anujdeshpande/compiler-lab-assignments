%{
/*
2. Write a lex program for 
      1. Counting the number of vowels in the file.
	  2. Counting the total number of words in the file.
	  3. Counting the total number of lines in the file.
	  4. Converting decimal numbers found in file to binary.

*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
		unsigned wordcount=0, linecount=0, vowelcount=0;
		int dec2bin(char *);
%}

%%

[aeiouAEIOU] {vowelcount++;}
[ \t]+ {wordcount++;}
[\n] {linecount++;wordcount++;}
[0-9] {dec2bin(yytext);}
. {;}

%%

int main(int argc, char *argv[]) 
{
		yyin=fopen(argv[1],"r");
		yylex();
		printf("\n linecount=%d wordcount=%d vowelcount=%d \n",linecount, wordcount, vowelcount);

}

int yywrap()
{
		return 1;
}
int dec2bin( char*num)
{
		int d;
		int remainder,quotient;
		int binaryNumber[100],i=1,j;
		d=atoi(num);
		quotient = d;
		while(quotient!=0){
				
				binaryNumber[i++]= quotient % 2;
				
				quotient = quotient / 2;
		}
		printf("%d ",d);
		for(j = i -1 ;j> 0;j--)
				printf("%d",binaryNumber[j]);
		printf("\n");
		return 0;
}
