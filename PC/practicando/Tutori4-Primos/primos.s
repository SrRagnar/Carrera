#1. Pedir entero al usuario (n)
#2. Si n es 0 terminar.
#3. Probar desde el 2 hasta el n-1 si es divisible
#4. Si se encontró divisible mostrar el encontrado.
#5. Caso contrario decir que es primo
#6. Volver al punto 1.

##include <iostream>

#int main() {
#  std::cout << "Este programa calcula si un numero es primo o no." << std::endl;
#  int numero_a_probar{1};
#  while (numero_a_probar != 0) {
#    std::cout << "Escribe un numero entero(0 para salir) ";
#    std::cin >> numero_a_probar;
#    if (numero_a_probar == 0) {
#      break;
#    }
#    int contador_divisores{0};
#    for (int i{2}; (i < numero_a_probar) && (contador_divisores == 0); ++i) {
#      if (!(numero_a_probar % i)) {
#        ++contador_divisores;
#        std::cout << "El divisor mas pequeño es: " << i;
#      }
#    }
#    if (contador_divisores == 0) {
#      std::cout << "El numero " << numero_a_probar << " es primo.";
#    }
#    std::cout << std::endl;
#  }
#}

# Asignacion de variables a registros
# numero_a_probar -> $s0
# contador_divisores -> $s1
# i -> $s2

       .data

str_titulo:            .asciiz     "Este programa calcula si un numero es primo o no.\n"
str_pregunta:          .asciiz     "Escribe un numero entero(0 para salir): "
str_primo:             .asciiz     "El numero dado es primo."
str_no_primo:          .asciiz     "El numero dado no es primo, su divisor mas pequeño es: "
str_salto:             .asciiz     "\n"
contador_iterador:     .word       2
contador_divisores:    .word       0
numero_dado:           .word       1
        .text
#int main() {
main:

#  std::cout << "Este programa calcula si un numero es primo o no." << std::endl;
        la $a0,str_pregunta
        li $v0,4
        syscall

#  int numero_a_probar{1};
#  while (numero_a_probar != 0) {
while:
        bne $s0,$zero,while_fin

#    std::cout << "Escribe un numero entero(0 para salir) ";
        la $a0,str_pregunta
        li $v0,4
        syscall

#    std::cin >> numero_a_probar;
        li $v0,5
        syscall
        move $s0,$v0

#    if (numero_a_probar == 0) {
ifn0:
        bne $s0,$zero,ifn0_fin
    
#      break;
        b while_fin

#    }
ifn0_fin:

#    int contador_divisores{0};
       lw $s1,contador_divisores

#    for (int i{2}; (i < numero_a_probar) && (contador_divisores == 0); ++i) {
        lw $s2,contador_iterador
for:
        seq $t0,$s1,$zero
        slt $t1,$s2,$s0
        and $t2,$t0,$t1
        beq $t2,$zero,for_fin
        
#      if (!(numero_a_probar % i)) {
ifn1:
       div $s0,$s2
       beq $lo,1,ifn1_fin
        
#        ++contador_divisores;
       addi $s1,$s1,1

#        std::cout << "El divisor mas pequeño es: " << i;
        li $v0,4
        la $a0,str_no_primo
        syscall

#      }
ifn1_fin:

#    }
for_fin:

#    if (contador_divisores == 0) {
ifn2:
      bne $s1,0,ifn2_fin

#      std::cout << "El numero " << numero_a_probar << " es primo.";
      li $v0,4
      la $a0,str_primo
      syscall

#    }
ifn2_fin:

#    std::cout << std::endl;
     li $v0,4
     la $a0,str_salto
     syscall
     
#  }
        b while
while_fin:
#}
       li $v0,10
       syscall