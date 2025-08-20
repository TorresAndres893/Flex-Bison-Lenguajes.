# Flex & Bison – Capítulo 1

## Tarea: Primeros Pasos con Flex y Bison

### Descripción General

Este repositorio contiene el desarrollo de los ejemplos y ejercicios del **Capítulo 1** del libro *Flex & Bison* (O’Reilly). El objetivo es familiarizarse con los conceptos fundamentales de Flex y Bison, analizando ejemplos básicos, ejecutándolos en un entorno Linux y resolviendo ejercicios prácticos que expanden la funcionalidad de los programas.

El trabajo se divide en dos fases:

1. **Análisis y ejecución de ejemplos (1-1 a 1-5).**
2. **Resolución de ejercicios propuestos (comentarios, calculadora hexadecimal, operadores bitwise, etc.).**

---

### Requisitos Previos

Antes de ejecutar el código asegúrese de tener instalado:

* **Flex**
* **Bison**
* **GCC** (compilador de C)

Verifique con:
```bash
flex --version
bison --version
gcc --version
```
---

### Instrucciones de Compilación y Ejecución

Ejemplo general para cualquier archivo `.l`:

```bash
flex archivo.l
gcc lex.yy.c -lfl -o salida
./salida
```

Para programas que incluyan **Bison**, se usaría:

```bash
bison -d archivo.y
flex archivo.l
gcc archivo.tab.c lex.yy.c -lfl -o salida
./salida
```

---

### Ejemplos (Capítulo 1)

* **Ejemplo 1-1:** Reconocimiento básico de tokens.
* **Ejemplo 1-2:** Introducción a patrones simples.
* **Ejemplo 1-3:** Uso de expresiones regulares.
* **Ejemplo 1-4:** Comparación entre escáner manual y generado.
* **Ejemplo 1-5:** Calculadora simple.

### Ejercicios Resueltos

1. **Manejo de comentarios:** Ajuste del escáner para aceptar líneas con comentarios.
2. **Calculadora Hexadecimal:** Implementación de soporte para números hexadecimales con `strtol`.
3. **Operadores a nivel de bits:** Inclusión de operadores `&` y `|`.
4. **Comparación de tokens:** Análisis de diferencias entre escáner manual y Flex.
5. **Limitaciones de Flex:** Discusión sobre lenguajes no regulares.
6. **Programa de conteo de palabras en C:** Comparación de rendimiento contra versión Flex.

---

