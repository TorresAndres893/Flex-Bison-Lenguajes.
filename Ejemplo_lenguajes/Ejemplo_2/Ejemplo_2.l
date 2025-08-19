/* English -> American */
%%
"colour" { printf("Version USA: color"); }
"flavour" { printf("Version USA: flavor"); }
"clever" { printf("Version: Usa: smart"); }
"smart" { printf("Version usa: elegant"); }
"conservative" { printf("Version Usa: liberal"); }
. { printf("%s", yytext); }
%%
