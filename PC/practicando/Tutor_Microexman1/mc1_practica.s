# Principio de Computadores. Preparación para el Microexamen
# Operaciones con funciones y direccionamiento indirecto
# Autor: 
# Fecha última modificación: 
#include <iostream>

# const int n1 = 10;
# double v1[n1] = {10.5, 9.5, 7.25, 6.25, 5.75, 4.5, 4.25, 3.5, -1.5, -2.0};
# const int n2 = 5;
# double v2[n2] = {5.5, 4.5, 4.25, 2.5, 2.5 };
# const int n3 = 4;
# double v3[n3] = {7.0, 5.0, 2.0, 1.0};

sizeD = 8
LF = 10
SPACE = 32

    .data
n1:     .word 10
v1:     .double 10.5, 9.5, 7.25, 6.25, 5.75, 4.5, 4.25, 3.5, -1.5, -2.0
n2:     .word 5
v2:     .double 5.5, 4.5, 4.25, 2.5, 2.5
n3:     .word 4
v3:     .double 7.0, 5.0, 2.0, 1.0
cad1:   .asciiz "\nVector con dimension "
cad2:   .asciiz "\nIntentando mezcla con dos vectores ...\n"
cad3:   .asciiz "\nFIN DEL PROGRAMA\n"

    .text

# void printvec(double *v, const int n) {
printvec:
       # PUSH $ra $s0 $s1 $s2
       addi $sp,$sp,-16
       sw $ra,0($sp)
       sw $s0,4($sp)
       sw $s1,8($sp)
       sw $s2,12($sp)

       # PUSH $ra $s0 $s1 $s2 $f20
       addi $sp,$sp,-24
       sw $ra,0($sp)
       sw $s0,4($sp)
       sw $s1,8($sp)
       sw $s2,12($sp)
       s.d $f20,16($sp)

       move $s0,$a0
       move $s1,$a1

       move $s2,$zero
#     for (int i = 0; i < n; i++)
for_printvec:

#         std::cout << v[i] << " ";
       mul $t0,$s2,$sizeD
       addu $t0,$t0,$s0
       
       # v[i] -> $f12
       l.d $f12,0($t0)
       li $v0,3
       syscall

for_printvec_fin:

#     std::cout << "\n";
       li $v0,11
       li $a0,LF
       syscall

#     return;
       # PUSH       
       lw $ra,0($sp)
       lw $s0,4($sp)
       lw $s1,8($sp)
       lw $s2,12($sp)
       addi $sp,$sp,16

       jr $ra

# }
printvec_fin:

# int ordenado(double *v, const int n) {
ordenado:

#     int resultado = 1;
       li $t0,1

#     int i = 0;
       li $t1,0

#     while (i < n-1) {
while_ordenado:
       li $t2,1
       sub $t7,$a1,$t2
       bge $t1,$t7,while_ordenado_fin

#         if (v[i+1] >= v[i]) {
if_ordenado:
       add $t3,$t1,$t2
       mul $t3,$t3,sizeD
       addu $t3,$t3,$a0
       l.d $f4,0($t3)

       mul $t4,$t1,sizeD
       addu $t4,$t4,$a0
       l.d $f6,0($t4)
       
       c.lt.d $f4,$f6
       bc1t if_ordenado_fin

#             resultado = 0;
       move $t0,$zero

#             break;
       jr $ra

#         }
if_ordenado_fin:

#         i++;
       addi $t1,$t1,1

#     }
       b while
while_ordenado_fin:

#     return(resultado);
# }
ordenado_fin:

# void merge(double *v1, const int n1,double *v2, const int n2) {
#     int  o1 = ordenado(v1,n1);
#     if (o1 == 0) return;
#     int o2 = ordenado(v2,n2);
#     if (o2 == 0) return;
#     int i = 0; // índice para recorrer el v1
#     int j = 0; // índice para recorrer el v2
#     while ( ( i < n1) && (j < n2) ) {
#         if (v1[i] >= v2[j]) {
#             std::cout << v1[i] << " ";
#             i++;
#         }
#         else {
#             std::cout << v2[j] << " ";
#             j++;
#         }
#     }
#     while ( i < n1) {
#         std::cout << v1[i] << " ";
#         i++;
#     }
#     while ( j < n2) {
#         std::cout << v2[j] << " ";
#         j++;
#     }
#     std::cout << "\n";
#     return;
# }

# int main(void) {
main:

#     std::cout << "\nVector con dimension " << n1 << std::endl;
       li $v0,4
       la $a0,cad1
       syscall
       li $v0,1
       lw $a0,n1
       syscall

#     printvec(v1,n1);
       la $a0,v1
       lw $a1,n1
       jal printvec
  
#     std::cout << "\nVector con dimension " << n2 << std::endl;
       li $v0,4
       la $a0,cad1
       syscall
       li $v0,1
       lw $a0,n2
       syscall

#     printvec(v2,n2);
       la $a0,v2
       lw $a1,n2
       jal printvec
  
#     std::cout << "\nVector con dimension " << n3 << std::endl;
       li $v0,4
       la $a0,cad1
       syscall
       li $v0,1
       lw $a0,n3
       syscall

#     printvec(v3,n3);
       la $a0,v3
       lw $a1,n3
       jal printvec
  
#     std::cout << "\nIntentando mezcla con dos vectores ...\n";
       li $v0,4
       la $a0,cad2
       syscall

#     merge(v1,n1,v2,n2);
       la $a0,v1
       lw $a1,n1
       la $a2,v2
       lw $a3,n2
       jal merge

#     std::cout << "\nIntentando mezcla con dos vectores ...\n";
       li $v0,4
       la $a0,cad2
       syscall

#     merge(v1,n1,v3,n3);
       la $a0,v1
       lw $a1,n1
       la $a2,v3
       lw $a3,n3
       jal merge

#     std::cout << "\nFIN DEL PROGRAMA\n";
       li $v0,4
       la $a0,cad3
       syscall
       
#     return(0);
# }
li $v0,10
syscall
