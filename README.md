# Flex & Bison – Capítulo 1


### Descripción General

Este repositorio documenta los **ejemplos y ejercicios del Capítulo 1** del libro *Flex & Bison* (O’Reilly).
El propósito es adquirir experiencia práctica en el uso de **Flex** y **Bison**, construyendo analizadores léxicos y sintácticos básicos que sirvan de base para aplicaciones más complejas.

Se trabajó en dos fases:

1. **Ejemplos guiados (1-1 a 1-5):** implementación, compilación y análisis de resultados.
2. **Ejercicios propuestos:** extensión de funcionalidades como manejo de comentarios, operadores adicionales y soporte para otros formatos numéricos.

---

### Requisitos Previos

Es necesario contar con las siguientes herramientas en el entorno Linux:

* **Flex**
* **Bison**
* **GCC**

Verificación:

```bash
flex --version
bison --version
gcc --version
```

---

### Ejemplos

---

#### **Ejemplo 1-1: Reconocimiento básico de tokens**

**Descripción:** Analizador que cuenta líneas, palabras y caracteres en un archivo de texto.

**Explicación breve:** Reconoce secuencias de caracteres alfabéticos como palabras y aplica un conteo acumulativo, similar al programa `wc` de Unix.

**Ejecución:**

```bash
flex Ejemplo_1.l
gcc lex.yy.c -lfl -o Ejemplo_1
./a.out
```

**Entrada:**

```
Hola mundo
Adiós mundo
```

**Salida:**

```
Líneas: 2  Palabras: 4  Caracteres: 21
```

**Notas:**

* Uso de patrones regulares simples (`[a-zA-Z]+`) para identificar palabras.
* Limitación: no se consideran acentos ni símbolos especiales.

---

#### **Ejemplo 1-2: Traducción de variantes del inglés**

**Descripción:** Escáner que transforma palabras del inglés británico a su equivalente en inglés americano.

**Explicación breve:** Cada coincidencia de palabra es sustituida directamente por su forma equivalente predefinida.

**Ejecución:**

```bash
flex Ejemplo_2.l
gcc lex.yy.c -lfl -o Ejemplo_2
./a.out
```

**Entrada:**

```
colour
flavour
clever
smart
conservative
```

**Salida:**

```
Version USA: color
Version USA: flavor
Version: Usa: smart
Version usa: elegant
Version Usa: liberal
```

**Notas:**

* Ejemplo de sustitución directa de cadenas.
* Ilustra la diferencia entre variantes lingüísticas del inglés.

---

#### **Ejemplo 1-3: Reconocimiento de operadores y números**

**Descripción:** Escáner que reconoce números, operadores aritméticos y clasifica cualquier carácter no contemplado como “misterioso”.

**Explicación breve:** Se aplican reglas específicas para operadores y números enteros; un patrón general captura caracteres no reconocidos.

**Ejecución:**

```bash
flex Ejemplo_3.l
gcc lex.yy.c -lfl -o Ejemplo_3
./a.out
```

**Entrada:**

```
2+2
23*34
76/we
```

**Salida:**

```
NUMBER 2
PLUS
NUMBER 2

NEWLINE
NUMBER 23
TIMES
NUMBER 34

NEWLINE
NUMBER 76
DIVIDE
Mystery character w
Mystery character e

NEWLINE
```

**Notas:**

* El programa cumple con la identificación de reglas definidas.
* Todo carácter fuera de las reglas es correctamente clasificado como “misterioso”.

---

#### **Ejemplo 1-4: Definición explícita de tokens**

**Descripción:** Extiende el reconocimiento léxico para asociar cada token con un valor numérico único y transmitirlo a fases posteriores.

**Explicación breve:** Los números se almacenan en `yylval` para ser consumidos posteriormente; operadores y caracteres no reconocidos se diferencian mediante tokens numéricos y mensajes de error.

**Ejecución:**

```bash
flex Ejemplo_4.l
gcc lex.yy.c -lfl -o Ejemplo_4
./a.out
```

**Entrada:**

```
a / 56 + 75
```

**Salida:**

```
Mystery character a
262
258 = 56
259
258 = 75
264
```

**Notas:**

* Se observa cómo Flex prepara la información para que un parser (Bison) procese expresiones completas.
* Diferencia entre tokens con valor ( numeros ) y tokens simbólicos (operadores).

---

#### **Ejemplo 1-5: Calculadora con Flex y Bison**

**Descripción:** Implementación de una calculadora simple con precedencia de operadores.

**Explicación breve:** Se utiliza un analizador sintáctico (Bison) que procesa los tokens generados por Flex, aplicando las reglas de precedencia para obtener el resultado de expresiones aritméticas.

**Compilación manual:**

```bash
bison -d Ejemplo_5.y
flex Ejemplo_5.l
gcc Ejemplo_5.tab.c lex.yy.c -lfl -o Ejemplo_5
./Ejemplo_5
```

**Entrada y salida esperada:**

```
2 + 3 * 4    → = 14
2 * 3 + 4    → = 10
20 / 4 - 2   → = 3
```
**Error Presentado**


El libro usa cc, pero en muchos sistemas modernos este comando no está disponible, por lo que debe sustituirse por gcc. Al ejecutar el ejemplo con cc, se obtuvo el error:
```bash
Ejemplo_5:: command not found
/usr/bin/ld: ... undefined reference to `yylval'
collect2: error: ld returned 1 exit status
```

Esto ocurre porque flex y bison generan archivos que dependen de yylval, definido en el parser (.tab.c y .tab.h). Si no se compilan juntos, el linker no encuentra esa referencia.
La corrección es compilar con:
```bash
bison -d Ejemplo_5.y
flex Ejemplo_5.l
gcc Ejemplo_5.tab.c lex.yy.c -lfl -o Ejemplo_5
```
**Notas:**

* Requiere `gcc` en lugar de `cc` para evitar errores de enlace.
* Se valida la precedencia de operadores: `*` y `/` tienen mayor prioridad que `+` y `-`.
* Los errores de sintaxis son reportados por la función `yyerror`.

---

### Ejercicios Resueltos
Perfecto 👍. Aquí te dejo el **README** más compacto, manteniendo las **preguntas originales**, las **respuestas** y solo la **esencia de la explicación**.

---

# **Ejercicios Resueltos**

---

## 1. Manejo de comentarios

**Pregunta:** ¿Aceptará la calculadora una línea que contenga solo un comentario? ¿Por qué no? ¿Sería más fácil corregir esto en el scanner o en el parser?
**Respuesta:** No, porque el parser espera un token válido y el scanner descarta el comentario.
**Explicación:** Lo más simple es ignorarlo en el scanner:

```lex
"//".*   { /* Ignorar comentario */ }
```

---

## 2. Calculadora hexadecimal

**Pregunta:** Convierte la calculadora en una calculadora hexadecimal que acepte hex y decimales.
**Respuesta:** Sí, usando `strtol` en el scanner y ajustando `printf` en el parser.
**Explicación:**

```lex
0x[0-9a-fA-F]+ { yylval = strtol(yytext, NULL, 16); return NUMBER; }
```

```c
printf("Resultado: %d (0x%X)\n", resultado, resultado);
```

---

## 3. Operadores bitwise

**Pregunta:** Agrega AND y OR. ¿Qué ocurre si `|` se usa como OR y como ABS?
**Respuesta:** Puede generar ambigüedad, pero se distingue por contexto.
**Explicación:**

```lex
"&" return AND; "|" return OR;
```

```yacc
exp: exp AND exp { $$ = $1 & $3; }
   | exp OR exp  { $$ = $1 | $3; }
```

---

## 4. Comparación manual vs. Flex

**Pregunta:** ¿El scanner manual reconoce lo mismo que Flex?
**Respuesta:** No.
**Explicación:** El manual falla en espacios y caracteres imprevistos; Flex es más robusto.

---

## 5. Limitaciones de Flex

**Pregunta:** ¿Lenguajes donde Flex no sirve?
**Respuesta:** Sí, los que dependen de contexto (ej. Python con indentación).

---

## 6. Conteo de palabras en C

**Pregunta:** Reescribe el programa y compara. ¿Es más rápido en C? ¿Más difícil de depurar?
**Respuesta:** Sí, más rápido pero menos flexible y más duro de depurar.
**Código:**

```c
#include <stdio.h>
#include <ctype.h>
int main(void)
{int c,in=0,cnt=0;
while((c=getchar())!=EOF){
if(isspace(c))in=0;
else if(!in){
in=1;cnt++;}}
printf("Palabras: %d\n",cnt);}
```
