#// Programa con funciones

##include <iostream>

#// devuelve 1 si a es divisible entre b, 0 en caso contrario
#int divisible(int a, int b) {
#  int resto = a % b;
#  int divisible = 0;
#  if (resto == 0) {
#    divisible = 1;
#  }
#  return divisible;
#}

#// devuelve el mayor divisor de x
#int mayorDivisor(int x) {
#  for (int d = (x-1); d > 1; d--) {
#    int divis = divisible(x,d);
#    if (divis) {
#      return d;
#    }
#  }
#  return 1;
#}

#int main() {
#  int n;
#  std::cout << "Introduce numero: ";
#  std::cin >> n;
#  int mayorDiv = mayorDivisor(n);
#  std::cout << mayorDiv << " es mayor divisor de " << n << "\n";
#}

	.data
strIntroduce:	.asciiz	"Introduce numero: "
strEsMayor:	.asciiz	" es mayor divisor de "
strSaltoL:	.asciiz	"\n"

	.text
# ############################################################
#// devuelve 1 si a es divisible entre b, 0 en caso contrario
#int divisible(int a, int b) {
# int a -> $a0
# int b -> $a1
# int resto -> $t0
# int divisible -> $v0
divisible:
#  int resto = a % b;
	div	$a0,$a1
	mfhi	$t0

#  int divisible = 0;
	li	$v0,0
ifResto0:
#  if (resto == 0) {
	bnez	$t0,ifResto0_fin
#    divisible = 1;
	li	$v0,1
#  }
ifResto0_fin:

#  return divisible;
#}                    
	jr	$ra

# ############################################################
#// devuelve el mayor divisor de x
#int mayorDivisor(int x) {
# x -> $a0 -> $s2                   
# valor devuelto -> $v0
# d -> $s0          Se ponen en registros s las variables que tienen que sobrevivir, ante la duda usar regsitro s
# divis -> $s1

mayorDivisor:
          # PUSH ra, s0, s1, s2

          move $s2,$a0
# 
#  for (int d = (x-1); d > 1; d--) {
#    int divis = divisible(x,d);
          move $a0,$s2   # Damos el valor a los parametros de divisinle que se guardan en los regisros a0 y a1
          move $a1,$s0
          jal divisible
          move $s1,$v0   # Guardamis el retornado de la funcion en el registro pertinente

#    if (divis) {
#      return d;
          move $v0,$a0
          b mayorDivisor_salida
          
#    }
#  }
#  return 1;
#}
mayorDivisor_salida:
          # POP ra, s0, s1, s2       FALTA IMPLEMENTAR LOS POP Y LOS PUSH PARA GUARDAR Y RESTAURAR LOS VALORES QUE TIENEN QUE SOBREVIVIR

          jr $ra

# ############################################################
#int main() {
# int n -> $s0
# int mayorDiv -> $s1
main:
#  int n;
#  std::cout << "Introduce numero: ";
	li	$v0,4
	la	$a0,strIntroduce
	syscall

#  std::cin >> n;
	li	$v0,5
	syscall
	move	$s0,$v0

#  int mayorDiv = mayorDivisor(n);

#  std::cout << mayorDiv << " es mayor divisor de " << n << "\n";
	li	$v0,1
	move	$a0,$s1
	syscall

	li	$v0,4
	la	$a0,strEsMayor
	syscall

	li	$v0,1
	move	$a0,$s0
	syscall

	li	$v0,4
	la	$a0,strSaltoL
	syscall

#}
	li	$v0,10
	syscall

