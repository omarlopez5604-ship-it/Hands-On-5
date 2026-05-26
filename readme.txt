# Mini Compilador con Flex y Bison

## Descripción
Este proyecto consiste en la implementación de un compilador básico usando Flex y Bison.

El compilador soporta:
- Variables
- Operaciones aritméticas (+, -, *, /)
- Asignaciones
- Impresión de resultados con `print`

---

## Tecnologías utilizadas
- Flex
- Bison
- GCC

---

## Cómo compilar

```bash
bison -d parser.y
flex lexer.l
gcc parser.tab.c lex.yy.c -o compilador