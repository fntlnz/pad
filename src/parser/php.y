%{
#include <cstdio>
#include <iostream>
#include <string>
using namespace std;

// stuff from flex that bison needs to know about:
extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;
 
void yyerror (char const *msg);
%}

%locations

%union {
	int ival;
	float fval;
	char *sval;
    std::string *realstringval;
}

%token <sval> TOKEN_STRING

%token TOKEN_OPEN_TAG
%token TOKEN_CLOSE_TAG
%token TOKEN_NAMESPACE
%token TOKEN_NAMESPACE_SEPARATOR

%type <realstringval> namespace_name
%%

pad:
    TOKEN_OPEN_TAG top_statements TOKEN_CLOSE_TAG
    ;

top_statements:
    top_statements top_statement { cout << "uno" << endl; }
    | /* empty */  { cout << "due" << endl; } /* allocate statement list when a data structure is available to do so */

top_statement:
    TOKEN_NAMESPACE namespace_name ';' { cout << "Namespace: " << *$2 << endl; }
    ;

namespace_name:
    TOKEN_STRING { std::string *token_string = new std::string($1); $$ = token_string; }
    | namespace_name TOKEN_NAMESPACE_SEPARATOR TOKEN_STRING {
        $1->append("\\");
        $1->append($3);
        $$ = $1;
    }
    ;

%%

int main(int, char**) {
	// open a file handle to a particular file:
	FILE *myfile = fopen("test.php", "r");
	// make sure it is valid:
	if (!myfile) {
		cout << "I can't open test.php!" << endl;
		return -1;
	}
	// set flex to read from it instead of defaulting to STDIN:
	yyin = myfile;
	
	// parse through the input until there is no more:
	do {
		yyparse();
	} while (!feof(yyin));
	
}

void yyerror (char const *msg) {
	cout << "EEK, parse error!  Message: " << msg << "line: " << yylloc.first_line << endl;
    cout << "Parse error" << endl;
    cout << "Message: " << msg << endl;
    cout << "Context: " << endl;
    cout << "   Line: " << yylloc.first_line << endl;
    cout << "   First Column: " << yylloc.first_column << endl;
    cout << "   Last Column: " << yylloc.last_column << endl;

	// might as well halt now:
	exit(-1);
}
