
.data

.text

subrutina_pop_multiple:  # Para sacar 3 elementos de la pila 
        lw $s0,0($sp)
        lw $ra,4($sp)
        lw $s1,8($sp)
        addi $sp,$sp,12  # Se actauliza la posicion de la cima de la pila, la pila crece hacia abajo asi que se suma para retroceder

# Para hacer un push multiple:
#        addi $sp,$sp,-12
#        sw $s0,0($sp)
#        sw $ra,4($sp)
#        sw $s1,8($sp)

main: