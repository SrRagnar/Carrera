.data

cadena:   .asciiz  "El resultado es: "
cadena15: .asciiz "quince."
cadena16: .asciiz "dieciseis."
cadenanula: .asciiz "nulo."
numero_1: .word    5
numero_2: .word    10
suma:     .word    0

.text

main:
    lw $t0,numero_1
    lw $t1,numero_2
    lw $t2,suma
    addi $t0.$t0,1
    add $t2,$t1,$t0
    sw $t0,numero_1
    sw $t2,suma
    la $a0,cadena
    li $v0,4
    syscall
switch:
    beq $t2,15,caso_15
    beq $t2,16,caso_16
    b caso_nulo
caso_15:
    la $a0,cadena15
    li $v0,4
    syscall
    b switch_fin
caso_16:
    la $a0,cadena16
    li $v0,4
    syscall
    b switch_fin
caso_nulo:
    la $a0,cadenanula
    li $v0,4
    syscall
switch_fin:
    li $v0,10
    syscall
           

