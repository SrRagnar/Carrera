 sizeW = 4
 N = 10   # Esto es como hacer un define
 
    .data
vector:     .word    7, 2, 6, 8, 1, 9, 10, 3, 4, 5   # Asi se define un vectore de enteros
espacio:    .asciiz " "

    .text
    
    la $s0,vector # Asi se carga la direccion de un array en un registro (igual que con los strigs que son arrays de caracteres)
    li $s1,3

    mul $t0,$s1,sizeW   #(Como cada word ocupa 4 bytes, por cada posicion que quieras avanzar tienes que desplazar 4 (3 * 4 = 12 para la posicion 3))
    addu $t1,$s0,$t0   # Guardamos en el registro t0 la direccion del tercer elemento de la posicion 3 del array (empiezan en 0 las posiciones)
    sw $zero,0($t1)  # Esto es como hacer vector[3] = 0

    move $s2,0($t1)  # valor = vector[3]
    
    li $v0,1
    move $a0,$s2  # std::cout << valor
    syscall

    li $v0,4
    la $a0,espacio #std::cout << " "
    syscall


    li $s3,6  # Almacenamos el nuevo indice en el registro s3
    li $v0,10
    syscall
    addu $t3,$s0,$t2  # Direccion de la posicion 

    move $s4,0($t3)   # valor = vector[6]

    li $v0,1
    move $a0,$s4
    syscall        # std::cout << valor

# Escribir el array posicion a posicion

    li $t4,0 # Posicion e iterador del for
    li $s5,N
for:     
    bge $t4,$s5,for_fin

    mul $t5,$t4,$sizeW
    addu $t6,$s0,$t5
    mov $t7,0($t6)
    
    li $v0,1
    move $a0,$t7
    syscall

    addi $t4,$t4,1
    b for
for_fin:


    li $v0,10
    syscall

