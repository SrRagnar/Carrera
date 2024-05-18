#1. Pedir entero al usuario (error)
#2. Si error es mayor a 0.00001 0 volver a repetir el proceso.
#3. Mientras el error entre los pasos sea mayor al error dado, realizar la 
#   serie del numero e
#4. Devolver el resultado conseguido y terminar el programa.

# #include <iostream>
# #include <iomanip>

# int main(int argc, char *argv[])
# {
#     double error = 0;
#     double e = 1; // 1/0!
#     double fact = 1; // 0!
#     double numterminos = 1;
#     double ultimo_termino = 1; ; // 1/0!
# 
#     std::cout << "\nPR1: Principio de computadores.\n";
#     do {
#         std::cout << "\nIntroduzca maximo error permitido: ";
#         std::cin >> error;
#         if (!(error >= 0.00001 && error < 1))
#             std::cout << "\nError: el dato introducido debe cumplir 0.00001 #                          <= dato < 1\n";
#         else break;
#     } while (true);
# 
#     while (ultimo_termino >= error) {
#         fact *= numterminos;
#         ultimo_termino = 1/fact;
#         e += ultimo_termino;
#         numterminos++;
#     }
#     std::cout <<  "\nNumero e: ";
#     std::cout << std::fixed << std::setprecision(17) << e;
#     std::cout << "\nNumero de terminos: " << int(numterminos);
#     std::cout << "\nPR1: Fin del programa.\n";
#     return 0;
# }

# PR1. PRINCIPIO DE COMPUTADORES.
# Autor: Javier Acosta Portocarrero
# Fecha ultima modificacion: 22/02/2024

# Asignacion de variables a registros
# error -> $f20
# e -> $f22
# ultimo_termimo -> $f24
# fact -> $f26
# num_terminos -> $f28
# 0.00001 -> $f16
# 1.0 -> $f18

	.data

titulo:		.asciiz "\nPR1: Principio de computadores.\n"
pet:		.asciiz "\nIntroduzca maximo error permitido: "
caderr:		.asciiz "\nError: el dato introducido debe cumplir 0.00001 <= dato < 1\n"
cade:		.asciiz "\nNumero e: "
cadnt:		.asciiz "\nNumero de terminos: "
cadfin:		.asciiz "\nPR1: Fin del programa.\n"
e:          .double 1.0


	.text

	# int main(int argc, char *argv[])
main: 
    
# {
#     double error = 0;
        li.d $f20,0.0

#     double e = 1; // 1/0!
        l.d $f22,e

#     double fact = 1; // 0!
        li.d $f26,1.0

#     double numterminos = 1;
        li.d $f28,1.0

#     double ultimo_termino = 1; ; // 1/0!
        li.d $f24,1.0
# 
#     std::cout << "\nPR1: Principio de computadores.\n";
        li $v0,4
		la $a0,titulo
		syscall

#     do {
do_while:

#         std::cout << "\nIntroduzca maximo error permitido: ";
        li $v0,4
		la $a0,pet
		syscall

#         std::cin >> error;
        li $v0,7
		syscall
		mov.d $f20,$f0

#         if (!(error >= 0.00001 && error < 1))
if_condicion:
        li.d $f16,0.00001
		li.d $f18,1.0
        c.le.d $f16,$f20
		bc1f if_contenido
		c.lt.d $f20,$f18
		bc1f if_contenido
		b else
		  
if_contenido:

#             std::cout << "\nError: el dato introducido debe cumplir 0.00001 #                          <= dato < 1\n";
        li $v0,4
		la $a0,caderr
		syscall
		b if_fin
    
#         else break;
else:
        b do_while_fin;
if_fin:

#     } while (true);
do_while_condicion:
        b do_while

do_while_fin:

# 
#     while (ultimo_termino >= error) {
while:
        c.lt.d $f24,$f20
		bc1t while_fin

#         fact *= numterminos;
        mul.d $f26,$f26,$f28

#         ultimo_termino = 1/fact;
        div.d $f24,$f18,$f26

#         e += ultimo_termino;
        add.d $f22,$f22,$f24

#         numterminos++;
        add.d $f28,$f28,$f18

#     }
        b while

while_fin:

#     std::cout <<  "\nNumero e: ";
        li $v0,4
		la $a0,cade
		syscall

#     std::cout << std::fixed << std::setprecision(17) << e;
        s.d $f22,e
        li $v0,3
	    mov.d $f12,$f22
		syscall
		l.d $f22,e

#     std::cout << "\nNumero de terminos: " << int(numterminos);
        li $v0,4
		la $a0,cadnt
		syscall
		cvt.w.d $f28,$f28
		mfc1 $t0,$f28
		move $a0,$t0
		li $v0,1
		syscall

#     std::cout << "\nPR1: Fin del programa.\n";
        li $v0,4
		la $a0,cadfin
		syscall

#     return 0;
        li $v0,10
		syscall

# }


