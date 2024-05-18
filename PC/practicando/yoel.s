#
# #include <iostream>

# using namespace std;

# int main() {
# float peso;
# int altura;
# while (true) {
# cout << "Introduzca su peso en kilogramos (0 o menos para salir): ";
# cin >> peso;
# // Verifica si el peso introducido es 0 o negativo para salir del bucle
# if (peso <= 0.0) {
# break;
# }
# cout << "Introduzca su altura en centímetros: ";
# cin >> altura;
# if (altura <= 0)
# continue;
# // Convertir altura a metros
# float alturaEnMetros = altura / 100.0;
# // Cálculo del IMC
# float imc = peso / (alturaEnMetros * alturaEnMetros);
# cout << "Su IMC es: " << imc << endl;
# // Clasificación del IMC
# if (imc < 18.5) {
# cout << "Categoría: Bajo peso" << endl;
# } else if (imc >= 18.5 && imc <= 24.9) {
# cout << "Categoría: Normal" << endl;
# } else if (imc >= 25 && imc <= 29.9) {
# cout << "Categoría: Sobrepeso" << endl;
# } else {
# cout << "Categoría: Obeso" << endl;
# }
# cout << endl; // Línea en blanco para separar cada iteración
# }
# return 0;
# }

# Asignacion de variables
# peso --> $f20
# altura --> $s0
# alturaEnMetros --> $f22
# imc --> $24
# 0,0 --> $f4
# 100 --> $f6
# 18.0 --> $f10
# 25.0 -->  $f16
# 29.9 -->  $f18
 

      .data

msgPeso:      .asciiz "Introduzca su peso en kilogramos (0 o menos para salir): "
msgAltura:    .asciiz "\nIntroduzca su altura en centímetros: "
msgIMC:       .asciiz "\nSu IMC es: "
msgBajoPeso:  .asciiz "Categoría: Bajo peso\n"
msgNormal:    .asciiz "Categoría: Normal\n"
msgSobrepeso: .asciiz "Categoría: Sobrepeso\n"
msgObeso:     .asciiz "Categoría: Obeso\n"
newline:      .asciiz "\n"

      .text

# int main() {
main: 

# float peso;
# int altura;
# while (true) {
while:

# cout << "Introduzca su peso en kilogramos (0 o menos para salir): ";
        li $v0,4
        la $a0,msgPeso
        syscall

# cin >> peso;
        li $v0,6
        syscall
        mov.s $f20,$f0

# // Verifica si el peso introducido es 0 o negativo para salir del bucle
if:

# if (peso <= 0.0) {
        li.s $f4,0.0
        c.lt.s $f20,$f4
        bc1t if_fin

# break;
        b while_fin

# }
if_fin:

# cout << "Introduzca su altura en centímetros: ";
        li $v0,4
        la $a0,msgAltura
        syscall

# cin >> altura;
        li $v0,5
        syscall
        move $s0,$v0

# if (altura <= 0)
if_segundo:
        blt $s0,$zero,if_segundo_fin

# continue;
        b while
if_segundo_fin:

# // Convertir altura a metros
# float alturaEnMetros = altura / 100.0;
       mtc1 $s0,$f22
       cvt.s.w $f22,$f22
       div.s $f22,$f22,$f6

# // Cálculo del IMC
# float imc = peso / (alturaEnMetros * alturaEnMetros);
        mul.s $f8,$f22,$f22   #Guardo en un registro temporal el resultado de la multiplicacion
        div.s $f24,$f20,$f8

# cout << "Su IMC es: " << imc << endl;
        li $v0,4
        la $a0,msgIMC
        syscall

# // Clasificación del IMC
# if (imc < 18.5) {
if_cadena:
        li.s $f10,18.5
        c.lt.s $f10,$f24
        bc1t primer_else_if

# cout << "Categoría: Bajo peso" << endl;
        li $v0,4
        la $a0,msgBajoPeso
        syscall
        b if_cadena_fin

# } else if (imc >= 18.5 && imc <= 24.9) {
primer_else_if:
        c.lt.s $f24,$f10
        bc1t segundo_else_if
        c.le.s $f24,$f10
        bc1f segundo_else_if

# cout << "Categoría: Normal" << endl;
        li $v0,4
        la $a0,msgNormal
        syscall
        b if_cadena_fin

# } else if (imc >= 25 && imc <= 29.9) {
segundo_else_if:
        li.s $f16,25.0
        li.s $f18,29.9
        c.lt.s $f24,$f16    
        bc1t else
        c.le.s $f24,$f18
        bc1f else 

# cout << "Categoría: Sobrepeso" << endl;
        li $v0,4
        la $a0,msgSobrepeso
        syscall
        b if_cadena_fin

# } else {
else:  

# cout << "Categoría: Obeso" << endl;
        li $v0,4
        la $a0,msgObeso
        syscall

# }
if_cadena_fin:

# cout << endl; // Línea en blanco para separar cada iteración
        li $v0,4
        la $a0,newline
        syscall

# }
while_fin:

# return 0;
       li $v0,10
       syscall
# }