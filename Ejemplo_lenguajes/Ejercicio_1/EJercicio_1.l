/* Fragmento de Declaracion de Variables " %{%} " */
%{
int chars = 0; /* Contador para caracteres*/
int words = 0; /* Contador para palabras*/
int lines = 0; /* Contador para Saltos de linea*/
%}

/* Fragmento de Reglas */
/* 
	En el rango de el abecedario en mayuscula y minuscula se contara para palabras y caracteres. 
	Cuenta los saltos de linea y a su vez cuentas como caracter.
	Cuenta un espacio nulo como un caracter
*/
%%
[a-zA-Z]+  { words++; chars += strlen(yytext); } 
\n         { chars++; lines++; } 
.          { chars++; }

%%
/* Funcion principal */
/* Usando la funcion propia de lex "yylex" se realiza el conteo posteriormente se muestra la imformacion acorde a las reglas previamente dadas*/
int main(int argc, char **argv)
{
    yylex();
    printf("Lineas: %d Palabras: %d Caracteres: %d\n", lines, words, chars);
}
