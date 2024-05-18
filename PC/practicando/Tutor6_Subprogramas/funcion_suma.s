    . data
strTitulo:        .asciiz "Suma de numeros\n"
strMas:           .asciiz " + "
strIgual:         .asciiz " = "
strSalto:         .asciiz "\n"

    .text

# i -> $a0
# j -> $a1
# valor devuelto -> $v0
# suma -> $s2

sumaNumeros:
    add $v0,$a0,$a1

    jr $ra

main:

    li $v0,4
    la $a0,strTitulo
    syscall

    li $s0,4
    li $s1,5

    move $a0,$s0  # Salvamos los parametros
    move $a1,$s1
    jal sumaNumeros  # Llamamos a la subrutina (funcion)
    move $s2,$v0