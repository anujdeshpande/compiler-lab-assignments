%{
#include <stdio.h>
#include <string.h>
		unsigned wordcount=0, linecount=0, charcount=0, filecount=0;

		int file_num;
		int file_num_max;
		char **files;
		%}

%%

[0-9a-zA-Z]+ {wordcount++;charcount=charcount+yyleng;}
[\n]+ {linecount++;}
. {;}

%%


int main(int argc, char *argv[]) 
{
		file_num=1;
		file_num_max = argc;
		files = argv;
		if ( argc > 1 ) {
				if ( (yyin = fopen(argv[file_num],"r")) == 0 ) {
						perror(argv[file_num]);
						exit(1);
				}
		}
		while( yylex() )
				;
		printf("\n linecount=%d wordcount=%d charcount=%d \n",linecount, wordcount, charcount);

		return 0;
}

int yywrap() {
		fclose(yyin);
		if ( ++file_num < file_num_max ) {
				if ( (yyin = fopen(files[file_num],"r")) == 0 ) {
						perror(files[file_num]);
						exit(1);
				}
				return 0;
		} 
		else 
		{
				return 1;
		}
}
