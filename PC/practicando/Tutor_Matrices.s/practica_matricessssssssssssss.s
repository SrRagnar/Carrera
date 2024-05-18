# Solución PR3 curso 23-24
# Manejo de matrices con funciones
# Autor: Javier Acosta Portocarrero
# Fecha ultima modificacion: 14/04/2024

# #include <iostream>
# #include <iomanip>
# #include <cmath>
# #include <tuple>
#
# typedef struct {
#   int nFil;
#   int nCol;
#   float elementos[];
# } structMat;
#
#
# structMat mat1 {
#   6,
#   6,
#   {
#     11.11, 12.12, 13.13, 14.14, 15.15, 16.16,
#     21.21, 22.22, 23.23, 24.24, 25.25, 26.26,
#     31.31, 32.32, 33.33, 34.34, 35.35, 36.36,
#     41.41, 42.42, 43.43, 44.44, 45.45, 46.46,
#     51.51, 52.52, 53.53, 54.54, 55.55, 56.56,
#     61.61, 62.62, 63.63, 64.64, 65.65, 66.66
#   }
#};
#
# structMat mat2 {
#   7,
#   10,
#   {
#     -36.886, -58.201,  78.671,  19.092, -50.781,  33.961, -59.511, 12.347,  57.306,  -1.938,
#     -86.858, -81.852,  54.623, -22.574,  88.217,  64.374,  52.312, 47.918, -83.549,  19.041,
#      4.255, -36.842,  82.526,  27.394,  56.527,  39.448,  18.429, 97.057,  76.933,  14.583,
#     67.79 ,  -9.861, -96.191,  32.369, -18.494, -43.392,  39.857, 80.686, -36.87 , -17.786,
#     30.073,  89.938,  -6.889,  64.601, -85.018,  70.559, -48.853, -62.627, -60.147,  -5.524,
#     84.323, -51.718,  93.127, -10.757,  32.119,  98.214,  69.471, 73.814,   3.724,  57.208,
#     -41.528, -17.458, -64.226, -71.297, -98.745,   7.095, -79.112, 33.819,  63.531, -96.181
#   }
# };
#
# structMat mat3 {
#   1,
#   8,
#   {
#     -36.52,  35.3 ,  79.05, -58.69, -55.23, -19.44, -88.63, -93.61
#   }
# };
#
# structMat mat4 {
#   16,
#   1,
#   { -90.57, -65.11, -58.21, -73.23, -89.38, -79.25,  16.82,  66.3 ,
#     -96.14, -97.16, -24.66,   5.27, -33.5 , -13.09,  27.13, -74.83 }
# };
#
# structMat mat5 {
#   1,
#   1,
#  { 78.98 }
# };
#
# structMat mat6 {
#   0,
#   0,
#   { 0 }
# };
#
# float infinito = INFINITY;
# 
# void print_mat(structMat* mat) {
#   int nFil = mat->nFil;
#  int nCol = mat->nCol;
#  float* elem = mat->elementos;
#   std::cout << "\n\nLa matriz tiene dimension " << nFil << 'x' << nCol << '\n';
#   for(int f = 0; f < nFil; f++) {
#     for(int c = 0; c < nCol; c++) {
#       std::cout << elem[f*nCol + c] << ' ';
#     }
#     std::cout << '\n';
#   }
#  std::cout << '\n';
# }
#
# void change_elto(structMat* mat, int indF, int indC, float valor) {
#   int numCol = mat->nCol;
#   mat->elementos[indF * numCol + indC] = valor;
# }
#
# void swap(float* e1, float* e2) {
#   float temp1 = *e1;
#   float temp2 = *e2;
#   *e1 = temp2;
#   *e2 = temp1;
# }
# 
# void intercambia(structMat* mat, int indF, int indC) {
#   int numCol = mat->nCol;
#   int numFil = mat->nFil;
#   float* datos = mat->elementos;
#   float* e1 = &datos[indF * numCol + indC];
#   float* e2 = &datos[(numFil - indF - 1) * numCol + (numCol - indC - 1)];
#   swap(e1, e2);
# }
#
# std::tuple<float, int, int> find_min(structMat* mat) {
#   int numCol = mat->nCol;
#   int numFil = mat->nFil;
#   float* datos = mat->elementos;
#   float min = infinito;
#   int fmin = -1;
#   int cmin = -1;
#   for(int f = 0; f < numFil; f++) {
#     for(int c = 0; c < numCol; c++) {
#       float valor = datos[f * numCol + c];
#       if (valor < min) {
#         min = valor;
#         fmin = f;
#         cmin = c;
#       }
#     }
#   }
#   return {min, fmin, cmin};
# }
# 
# int main() {
#   std::cout << std::fixed << std::setprecision(8);  // Ignorar
#   std::cout << "\nComienza programa manejo matrices con funciones\n";
# 
#   structMat* matTrabajo = &mat1;
#   while(true) {
#     print_mat(matTrabajo);
#     std::cout <<
#     "(0) Terminar el programa\n"
#     "(1) Cambiar la matriz de trabajo\n"
#     "(3) Cambiar el valor de un elemento\n"
#     "(4) Intercambiar un elemento con su opuesto\n"
#     "(7) Encontrar el minimo\n"
#     "\nIntroduce opción elegida: ";
# 
#     int opcion;
#     std::cin >> opcion;
# 
# 
#     if(opcion == 0) {
#       break;
#     }
# 
#     // Opción 1 ////////////////////////////////////////////////////////////
#     if(opcion == 1) {
#       std::cout << "\nElije la matriz de trabajo (1..6): ";
#       int matT;
#       std::cin >> matT;
#       if (matT == 1) {
#         matTrabajo = &mat1;
#         continue;  // volvemos al principio del bucle
#       }
#       if (matT == 2) {
#         matTrabajo = &mat2;
#         continue;  // volvemos al principio del bucle
#       }
#       if (matT == 3) {
#         matTrabajo = &mat3;
#         continue;  // volvemos al principio del bucle
#       }
#       if (matT == 4) {
#         matTrabajo = &mat4;
#         continue;  // volvemos al principio del bucle
#       }
#       if (matT == 5) {
#         matTrabajo = &mat5;
#         continue;  // volvemos al principio del bucle
#       }
#      if (matT == 6) {
#         matTrabajo = &mat6;
#         continue;  // volvemos al principio del bucle
#       }
#      std::cout << "Numero de matriz de trabajo incorrecto\n";
#       continue;  // volvemos al principio del bucle
#     }
# 
#     // Opción 3  y  4 //////////////////////////////////////////////////////////
#     if(opcion == 3 || opcion == 4) {
#      std::cout << "\nIndice de fila: ";
#       int indFil;
#       std::cin >> indFil;
#       if ((indFil < 0) || (indFil >= matTrabajo->nFil)) {
#         std::cerr << "Error: dimension incorrecta.  Numero de fila incorrecto\n";
#         continue;  // volvemos al principio del bucle
#       }
#       std::cout << "Indice de columna: ";
#       int indCol;
#       std::cin >> indCol;
#       if ((indCol < 0) || (indCol >= matTrabajo->nCol)){
#         std::cerr << "Error: dimension incorrecta.  Numero de columna incorrecto\n";
#         continue;  // volvemos al principio del bucle
#       }
# 
#       if (opcion == 3) {
#         std::cout << "Nuevo valor para el elemento: ";
#         float valor;
#         std::cin >> valor;
#        change_elto(matTrabajo, indFil, indCol, valor);
#       }
#       if(opcion == 4) {
#        intercambia(matTrabajo, indFil, indCol);
#      }
# 
#       continue;
#     }
# 
#     // Opción 7 ////////////////////////////////////////////////////////////
#     if(opcion == 7) {
#       float valorMin;
#       int filaMin;
#       int columnaMin;
#       std::tie(valorMin, filaMin, columnaMin) = find_min(matTrabajo);
#       std::cout << "\nEl valor minimo esta en (" << filaMin << ','
#         << columnaMin <<") con valor " << valorMin;
#       continue;
#     }
# 
#     // Opción Incorrecta ///////////////////////////////////////////////////////
#     std::cout << "Error: opcion incorrecta\n";
#   }
#   std::cout << "\nTermina el programa\n";
# }

# Solución PR3 curso 23-24
# Manejo de matrices con funciones
# Autor: Javier Acosta Portocarrero
# Fecha ultima modificacion: 14/04/2024

#typedef struct {
#  int nFil;
nFil = 0	# El desplazamiento al campo dentro de la estructura
#  int nCol;
nCol = 4	# El desplazamiento al campo dentro de la estructura
#  float elementos[];
elementos = 8	# El desplazamiento al campo dentro de la estructura
#} structMat;
#

sizeF = 4	# Numero de bytes de un float
LF = 10		# Caracter salto de línea
	.data
#structMat mat1 {
#  6,
#  6,
#  {
#    11.11, 12.12, 13.13, 14.14, 15.15, 16.16,
#    21.21, 22.22, 23.23, 24.24, 25.25, 26.26,
#    31.31, 32.32, 33.33, 34.34, 35.35, 36.36,
#    41.41, 42.42, 43.43, 44.44, 45.45, 46.46,
#    51.51, 52.52, 53.53, 54.54, 55.55, 56.56,
#    61.61, 62.62, 63.63, 64.64, 65.65, 66.66
#  }
#};
mat1:	.word	6
	.word	6
	.float	11.11, 12.12, 13.13, 14.14, 15.15, 16.16,
	.float	21.21, 22.22, 23.23, 24.24, 25.25, 26.26,
	.float	31.31, 32.32, 33.33, 34.34, 35.35, 36.36,
	.float	41.41, 42.42, 43.43, 44.44, 45.45, 46.46,
	.float	51.51, 52.52, 53.53, 54.54, 55.55, 56.56,
	.float	61.61, 62.62, 63.63, 64.64, 65.65, 66.66

#structMat mat2 {
#  7,
#  10,
#  {
#    -36.886, -58.201,  78.671,  19.092, -50.781,  33.961, -59.511, 12.347,  57.306,  -1.938,
#    -86.858, -81.852,  54.623, -22.574,  88.217,  64.374,  52.312, 47.918, -83.549,  19.041,
#     4.255, -36.842,  82.526,  27.394,  56.527,  39.448,  18.429, 97.057,  76.933,  14.583,
#    67.79 ,  -9.861, -96.191,  32.369, -18.494, -43.392,  39.857, 80.686, -36.87 , -17.786,
#    30.073,  89.938,  -6.889,  64.601, -85.018,  70.559, -48.853, -62.627, -60.147,  -5.524,
#    84.323, -51.718,  93.127, -10.757,  32.119,  98.214,  69.471, 73.814,   3.724,  57.208,
#    -41.528, -17.458, -64.226, -71.297, -98.745,   7.095, -79.112, 33.819,  63.531, -96.181
#  }
#};
mat2:	.word	7
	.word	10
	.float	-36.886, -58.201,  78.671,  19.092, -50.781,  33.961, -59.511, 12.347,  57.306,  -1.938,
	.float	-86.858, -81.852,  54.623, -22.574,  88.217,  64.374,  52.312, 47.918, -83.549,  19.041,
	.float	4.255, -36.842,  82.526,  27.394,  56.527,  39.448,  18.429, 97.057,  76.933,  14.583,
	.float	67.79 ,  -9.861, -96.191,  32.369, -18.494, -43.392,  39.857, 80.686, -36.87 , -17.786,
	.float	30.073,  89.938,  -6.889,  64.601, -85.018,  70.559, -48.853, -62.627, -60.147,  -5.524,
	.float	84.323, -51.718,  93.127, -10.757,  32.119,  98.214,  69.471, 73.814,   3.724,  57.208,
	.float	-41.528, -17.458, -64.226, -71.297, -98.745,   7.095, -79.112, 33.819,  63.531, -96.181

# structMat mat3 {
#   1,
#   8,
#   {
#     -36.52,  35.3 ,  79.05, -58.69, -55.23, -19.44, -88.63, -93.61
#   }
# };
mat3:	.word	1
	.word	8
	.float	-36.52,  35.3 ,  79.05, -58.69, -55.23, -19.44, -88.63, -93.61

# structMat mat4 {
#   16,
#   1,
#   { -90.57, -65.11, -58.21, -73.23, -89.38, -79.25,  16.82,  66.3 ,
#     -96.14, -97.16, -24.66,   5.27, -33.5 , -13.09,  27.13, -74.83 }
# };
mat4:	.word	16
	.word	1
	.float	-90.57, -65.11, -58.21, -73.23, -89.38, -79.25,  16.82,  66.3
	.float	-96.14, -97.16, -24.66,   5.27, -33.5 , -13.09,  27.13, -74.83

# structMat mat5 {
#   1,
#   1,
#   { 78.98 }
# };
mat5:	.word	1
	.word	1
	.float	78.98

# structMat mat6 {
#   0,
#   0,
#   { 0 }
# };
mat6:	.word	0
	.word	0
	.float	0.0

#float infinito = INFINITY;
infinito:	.word	0x7F800000

# Cadenas de caracteres
str_titulo:	.asciiz	"\nComienza programa manejo matrices con funciones\n"
str_menu:	.ascii	"(0) Terminar el programa\n"
		.ascii	"(1) Cambiar la matriz de trabajo\n"
		.ascii	"(3) Cambiar el valor de un elemento\n"
		.ascii	"(4) Intercambiar un elemento con su opuesto\n"
		.ascii	"(7) Encontrar el minimo\n"
		.asciiz	"\nIntroduce opción elegida: "
str_errorOpc:	.asciiz	"Error: opcion incorrecta\n"
str_termina:	.asciiz	"\nTermina el programa\n"
str_elijeMat:	.asciiz	"\nElije la matriz de trabajo (1..6): "
str_numMatMal:	.asciiz	"Numero de matriz de trabajo incorrecto\n"
str_errorFil:	.asciiz	"Error: dimension incorrecta.  Numero de fila incorrecto\n"
str_errorCol:	.asciiz	"Error: dimension incorrecta.  Numero de columna incorrecto\n"
str_indFila:	.asciiz	"\nIndice de fila: "
str_indCol:	.asciiz	"Indice de columna: "
str_nuevoValor:	.asciiz	"Nuevo valor para el elemento: "
str_valMin:	.asciiz	"\nEl valor minimo esta en ("
str_conValor:	.asciiz	") con valor "
str_matTiene:	.asciiz	"\n\nLa matriz tiene dimension "

       .text

# Asignacion de variables a resgistros en sort_row:
# mat -> $a0 
# indF -> $a1 -> $s0
# nFil -> $s1
# nCol -> $s2
# elem -> $s3
# e1 -> $s4
# e2 -> $s5
# i -> $s6
# j -> $s7

# void sort_row(structMat* mat, int indF) {
sort_row:
       addi $sp,$sp,-36
       sw $ra,0($sp)
       sw $s0,4($sp)
       sw $s1,8($sp)
       sw $s2,12($sp)
       sw $s3,16($sp)
       sw $s4,20($sp)
       sw $s5,24($sp)
       sw $s6,28($sp)
       sw $s7,32($sp)

       move $s0,$a1

# int nFil = mat->nFil;
       lw $s1,nFil($a0)

# int nCol = mat->nCol;
       lw $s2,nCol($a0)

# float* elem = mat->elementos;
       la $s3,elementos($a0)

# float* e1;
# float* e2;

       move $s6,$zero
# for(int i = 0; i < nCol-1 ; i++) {
primer_for_sort_row:
       li $t0,1
       sub $t1,$s2,$t0
       bge $s6,$t1,primer_for_sort_row_fin

       move $s7,$zero
# for(int j = 0; j < nCol-1-i; j++) {
segundo_for_sort_row:
       li $t0,1
       sub $t1,$s2,$t0
       sub $t1,$t1,$s6
       bge $s7,$t1,segundo_for_sort_row_fin


# if ( elem[indF*nCol + j] > elem[indF*nCol + j+1] ) {
if_sort_row:
       mul  $t3,$s0,$s2   # f * nCol    
       addu $t3,$t3,$s7  # f * nCol + j
       mul $t3,$t3,sizeF  # (f * nCol + j) * tamElem
       addu $t3,$s3,$t3  # dirBase + (f * nCol + j) * tamElem

       l.s $f4,0($t3)

       mul  $t4,$s0,$s2   # f * nCol    
       addu $t4,$t4,$s7  # f * nCol + j
       addiu $t4,$t4,1
       mul $t4,$t4,sizeF  # (f * nCol + j) * tamElem
       addu $t4,$s3,$t4  # dirBase + (f * nCol + j) * tamElem

       l.s $f6,0($t4)     

       c.lt.s $f6,$f4
       bc1f if_sort_row_fin

# e1 = &elem[indF*nCol+j];
       move $s4,$t3

# e2 = &elem[indF*nCol+j+1];
       move $s5,$t4

# swap(e1,e2);
       move $a0,$s4
       move $a1,$s5
       jal swap
       
# }
if_sort_row_fin:

# }
       addi $s7,$s7,1
       b segundo_for_sort_row
segundo_for_sort_row_fin:

# }
       addi $s6,$s6,1
       b primer_for_sort_row
primer_for_sort_row_fin:

# }
       lw $ra,0($sp)
       lw $s0,4($sp)
       lw $s1,8($sp)
       lw $s2,12($sp)
       lw $s3,16($sp)
       lw $s4,20($sp)
       lw $s5,24($sp)
       lw $s6,28($sp)
       lw $s7,32($sp)
       addi $sp,$sp,36

       jr $ra
sort_row_fin:

# Asignacion de variables a resgistros en print_mat:
# mat -> $a0 -> $s0
# nFil -> $s1
# nCol -> $s2
# elem -> $s3
# f -> $s4
# c -> $s5

# void print_mat(structMat* mat) {
print_mat:
       # PUSH $s0 $s1 $s2 $s3 $s4 $s5 $ra
       addi $sp,$sp,-28
       sw $ra,0($sp)
       sw $s0,4($sp)
       sw $s1,8($sp)
       sw $s2,12($sp)
       sw $s3,16($sp)
       sw $s4,20($sp)
       sw $s5,24($sp)

       move $s0,$a0

#   int nFil = mat->nFil;
       lw $s1,nFil($s0)

#   int nCol = mat->nCol;
       lw $s2,nCol($s0)

#   float* elem = mat->elementos;
       la $s3,elementos($s0)

#   std::cout << "\n\nLa matriz tiene dimension " << nFil << 'x' << nCol << '\n';
       li $v0,4
       la $a0,str_matTiene
       syscall
       li $v0,1
       move $a0,$s1
       syscall
       li $v0,11
       li $a0,'x'
       syscall
       li $v0,1
       move $a0,$s2
       syscall
       li $v0,11
       li $a0,LF
       syscall

       move $s4,$zero
#   for(int f = 0; f < nFil; f++) {
primer_for_print_mat:
       bge $s4,$s1,primer_for_print_mat_fin
     
       move  $s5,$zero
#     for(int c = 0; c < nCol; c++) {
segundo_for_print_mat:
       bge $s5,$s2,segundo_for_print_mat_fin

#       std::cout << elem[f*nCol + c] << ' ';
      # $f12 = elem[f * nCol + c]
      # Usamos $t0 como resgistro temporal para calcular el desplazamiento del componente de la matriz 
       mul  $t0,$s4,$s2   # f * nCol    
       addu $t0,$t0,$s5  # f * nCol + c
       mul $t0,$t0,sizeF  # (f * nCol + c) * tamElem
       addu $t0,$s3,$t0  # dirBase + (f * nCol + c) * tamElem

# Mostramos por pantalla lo calculado
       l.s $f12,0($t0)
       li $v0,2
       syscall
       li $v0,11
       li $a0,' '
       syscall

# 
#     }
       addi $s5,$s5,1
       b segundo_for_print_mat
segundo_for_print_mat_fin:

# 
#     std::cout << '\n';
       li $v0,11
       li $a0,LF
       syscall

#   }
      addi $s4,$s4,1
      b primer_for_print_mat
primer_for_print_mat_fin:

#   std::cout << '\n';
       li $v0,11
       li $a0,LF
       syscall

# }
       # POP $s0 $s1 $s2 $s3 $s4 $s5 $ra
       lw $ra,0($sp)
       lw $s0,4($sp)
       lw $s1,8($sp)
       lw $s2,12($sp)
       lw $s3,16($sp)
       lw $s4,20($sp)
       lw $s5,24($sp)
       addi $sp,$sp,28
       jr $ra

print_mat_fin:

#

# Asignacion de variables a resgistros en change_elto:
# mat -> $a0
# indF -> $a1
# indC -> $a2
# numCol -> $t1
# valor -> $f12

# void change_elto(structMat* mat, int indF, int indC, float valor) {
change_elto:

#  int numCol = mat->nCol;
       lw $t1,nCol($a0)

#  mat->elementos[indF * numCol + indC] = valor;
       mul  $t0,$a1,$t1    # indF * numCol  
       addu $t0,$t0,$a2    # indF * numCol + indC  
       mul $t0,$t0,sizeF    # (indF * numCol + indC) * tamanopalabra  
       addu $t0,$t0,$a0    # (indF * numCol + indC) * tamanopalabra + dirbase
       addiu $t0,$t0,elementos    
       
       s.s $f12,0($t0)

# }
       jr $ra

change_elto_fin:

#


# Asignacion de variables a registros en swap:
# e1 -> $a0
# e2 -> $a1
# temp1 -> $f16
# temp2 -> $f18


# void swap(float* e1, float* e2) {
swap:

#   float temp1 = *e1;
       l.s $f16,0($a0)

#   float temp2 = *e2;
       l.s $f18,0($a1)

#   *e1 = temp2;
       s.s $f16,0($a1)

#   *e2 = temp1;
       s.s $f18,0($a0)

# }
       jr $ra

swap_fin:

#

# Asignacion de variables a registros en intercambia:
# mat -> $a0 -> $s0
# indf -> $a1 -> $s4
# indC -> $a2 -> $s5
# numFil -> $s1
# numCol -> $s2
# datos -> $s3

# void intercambia(structMat* mat, int indF, int indC) {
intercambia:
       # PUSH $s0 $s1 $s2 $s3 $s4 $s5 $ra
       addi $sp,$sp,-28
       sw $ra,0($sp)
       sw $s0,4($sp)
       sw $s1,8($sp)
       sw $s2,12($sp)
       sw $s3,16($sp)
       sw $s4,20($sp)
       sw $s5,24($sp)

       move $s0,$a0
       move $s4,$a1
       move $s5,$a2
      
#   int numCol = mat->nCol;
       lw $s2,nCol($s0)

#   int numFil = mat->nFil;
       lw $s1,nFil($s0)

#   float* datos = mat->elementos;
       la $s3,elementos($s0)

#   float* e1 = &datos[indF * numCol + indC];
       mul  $t4,$s4,$s2    # indF * numCol    
       addu $t4,$t4,$s5    # indF * numCol + indC
       mul $t4,$t4,sizeF    # (indF * numCol + indC) * tamanoPalabra
       addu $t4,$t4,$s3    # dirBase (indF * numCol + indC) * tamanoPalabra

#   float* e2 = &datos[(numFil - indF - 1) * numCol + (numCol - indC - 1)];
       sub $t5,$s1,$s4    # (numFil - indF - 1)
       sub $t5,$t5,1
       mul  $t5,$t5,$s2    # (numFil - indF - 1) * numCol
       sub $t6,$s2,$s5    # (numCol - indC - 1)
       li $t7,1
       sub $t6,$t6,$t7  
       addu $t5,$t5,$t6    # (numFil - indF - 1) * numCol + (numCol - indC - 1)
       mul $t5,$t5,sizeF    # ((numFil - indF - 1) * numCol + (numCol - indC - 1)) * tamanoPalabra  
       addu $t5,$t5,$s3    # ((numFil - indF - 1) * numCol + (numCol - indC - 1)) * tamanoPalabra + dirBase
       

#   swap(e1, e2);
       move $a0,$t4
       move $a1,$t5
       jal swap

# }
       # POP $s0 $s1 $s2 $s3 $s4 $s5 $ra
       lw $ra,0($sp)
       lw $s0,4($sp)
       lw $s1,8($sp)
       lw $s2,12($sp)
       lw $s3,16($sp)
       lw $s4,20($sp)
       lw $s5,24($sp)

       addi $sp,$sp,28
       jr $ra

intercambia_fin:

#

# Asignacion de variables a resgistros en find_min:
# mat -> $a0 
# numFil -> $t0
# numCol -> $t1
# datos -> $t2
# cmin -> $t3
# fmin -> $t4
# f -> $t5
# c -> $t6
# min -> $f16
# valor -> $f18
# entero devuelto (fmin) -> $v0
# entero devuelto (cmin) -> $v1
# float devuelto (min) -> $f0

# std::tuple<float, int, int> find_min(structMat* mat) {
find_min:
       
#   int numCol = mat->nCol;
       lw $t1,nCol($a0)

#   int numFil = mat->nFil;
       lw $t0,nFil($a0)

#   float* datos = mat->elementos;
       la $t2,elementos($a0)

#   float min = infinito;
       l.s $f16,infinito
       
#   int fmin = -1;
       li $t3,-1

#   int cmin = -1;
       li $t4,-1

       move $t5,$zero
#   for(int f = 0; f < numFil; f++) {
for_find_min:
       bge $t5,$t0,for_find_min_fin

       move $t6,$zero
#     for(int c = 0; c < numCol; c++) {
segundo_for_find_min:
       bge $t6,$t1,segundo_for_find_min_fin

#       float valor = datos[f * numCol + c];
       mul  $t7,$t5,$t1   # f * nCol
       addu $t7,$t7,$t6  # f * nCol + c
       mul $t7,$t7,sizeF  # (f * nCol + c) * tamElem
       addu $t7,$t2,$t7  # dirBase + (f * nCol + c) * tamElem

       l.s $f18,0($t7)

#       if (valor < min) {
if_find_min:
       c.lt.s $f18,$f16
       bc1f if_find_min_fin

#         min = valor;
       mov.s $f16,$f18     

#         fmin = f;
       move $t3,$t5

#         cmin = c;
       move $t4,$t6

#       }
if_find_min_fin:

#     }
       addi $t6,$t6,1
       b segundo_for_find_min
segundo_for_find_min_fin:

#   }
       addi $t5,$t5,1
       b for_find_min
for_find_min_fin:

#  return {min, fmin, cmin};
       mov.s $f0,$f16
       move $v0,$t3
       move $v1,$t4     

# }
       jr $ra
       
find_min_fin:

# Asignacion de variables a registros en el main:
# matT -> $t1
# indFil -> $s1 
# indCol -> $s2
# filaMin -> $s4
# columnaMin -> $s5
# matTrabajo -> $s6
# opcion -> $s7
# valor -> $f20
# valorMin -> $f24

# int main() {
main:

#   std::cout << std::fixed << std::setprecision(8);  // Ignorar
#   std::cout << "\nComienza programa manejo matrices con funciones\n";
       li $v0,4
       la $a0,str_titulo
       syscall
       
#   structMat* matTrabajo = &mat1;
       la $s6,mat1

#   while(true) {
while:

#     print_mat(matTrabajo);
       move $a0,$s6
       jal print_mat

#     std::cout <<
#     "(0) Terminar el programa\n"
#     "(1) Cambiar la matriz de trabajo\n"
#     "(3) Cambiar el valor de un elemento\n"
#     "(4) Intercambiar un elemento con su opuesto\n"
#     "(7) Encontrar el minimo\n"
#     "\nIntroduce opción elegida: ";
       li $v0,4
       la $a0,str_menu
       syscall

#
#     int opcion;
#     std::cin >> opcion;
       li $v0,5
       syscall 
       move $s7,$v0

#
#
#    if(opcion == 0) {
if_terminar_programa:
       bnez $s7,if_terminar_programa_fin

#       break;
       b fin_while

#     }
if_terminar_programa_fin:

#
#     // Opción 1 ////////////////////////////////////////////////////////////
#     if(opcion == 1) {
if_cambio_matriz:
       li $t7,1
       bne $s7,$t7,if_cambio_matriz_fin

#       std::cout << "\nElije la matriz de trabajo (1..6): ";
       li $v0,4
       la $a0,str_elijeMat
       syscall

#       int matT;
#       std::cin >> matT;
       li $v0,5
       syscall
       move $t1,$v0

#       if (matT == 1) {
primer_if_cambio_matriz:
       li $t7,1
       bne $t1,$t7,primer_if_cambio_matriz_fin

#         matTrabajo = &mat1;
       la $s6,mat1

#         continue;  // volvemos al principio del bucle
       b while

#       }
primer_if_cambio_matriz_fin:

#       if (matT == 2) {
segundo_if_cambio_matriz:
       li $t7,2
       bne $t1,$t7,segundo_if_cambio_matriz_fin

#         matTrabajo = &mat2;
       la $s6,mat2

#         continue;  // volvemos al principio del bucle
       b while

#       }
segundo_if_cambio_matriz_fin:

#       if (matT == 3) {
tercer_if_cambio_matriz:
       li $t7,3
       bne $t1,$t7,tercer_if_cambio_matriz_fin

#         matTrabajo = &mat3;
       la $s6,mat3

#         continue;  // volvemos al principio del bucle
       b while

#       }
tercer_if_cambio_matriz_fin:

#       if (matT == 4) {
cuarto_if_cambio_matriz:
       li $t7,4
       bne $t1,$t7,cuarto_if_cambio_matriz_fin

#         matTrabajo = &mat4;
       la $s6,mat4

#         continue;  // volvemos al principio del bucle
       b while

#       }
cuarto_if_cambio_matriz_fin:

#       if (matT == 5) {
quinto_if_cambio_matriz:
       li $t7,5
       bne $t1,$t7,quinto_if_cambio_matriz_fin

#         matTrabajo = &mat5;
       la $s6,mat5

#         continue;  // volvemos al principio del bucle
       b while

#       }
quinto_if_cambio_matriz_fin:

#       if (matT == 6) {
sexto_if_cambio_matriz:
       li $t7,6
       bne $t1,$t7,sexto_if_cambio_matriz_fin

#         matTrabajo = &mat6;
       la $s6,mat6

#         continue;  // volvemos al principio del bucle
       b while

#       }
sexto_if_cambio_matriz_fin:

#       std::cout << "Numero de matriz de trabajo incorrecto\n";
       li $v0,4
       la $a0,str_numMatMal
       syscall

#       continue;  // volvemos al principio del bucle
       b while

#     }
if_cambio_matriz_fin:

# 
#     // Opción 3  y  4 //////////////////////////////////////////////////////////
#     if(opcion == 3 || opcion == 4) {
if_cambiar_intercambiar:
       li $t7,3
       beq $s7,$t7,if_cambiar_intercambiar_contenido
       li $t6,4
       beq $s7,$t6,if_cambiar_intercambiar_contenido
       b if_cambiar_intercambiar_fin

if_cambiar_intercambiar_contenido:

#       std::cout << "\nIndice de fila: ";
       li $v0,4
       la $a0,str_indFila
       syscall

#       int indFil;
#       std::cin >> indFil;
       li $v0,5
       syscall
       move $s1,$v0

#       if ((indFil < 0) || (indFil >= matTrabajo->nFil)) {
if_error_fila:
       bltz $s1,if_error_fila_contenido
       lw $t1,nFil($s6)    # Usamos el registro temporal t1 para guardar nFil
       bge $s1,$t1,if_error_fila_contenido
       b if_error_fila_fin

if_error_fila_contenido:

#         std::cerr << "Error: dimension incorrecta.  Numero de fila incorrecto\n";
       li $v0,4
       la $a0,str_errorFil
       syscall

#         continue;  // volvemos al principio del bucle
       b while

#       }
if_error_fila_fin:

#       std::cout << "Indice de columna: ";
       li $v0,4
       la $a0,str_indCol
       syscall

#       int indCol;
#       std::cin >> indCol;
       li $v0,5
       syscall
       move $s2,$v0

#       if ((indCol < 0) || (indCol >= matTrabajo->nCol)){
if_error_columna:
       bltz $s2,if_error_columna_contenido
       lw $t1,nCol($s6)    # Usamos el registro temporal t1 para guardar nCol
       bge $s2,$t1,if_error_columna_contenido
       b if_error_columna_fin

if_error_columna_contenido:

#          
#         std::cerr << "Error: dimension incorrecta.  Numero de columna incorrecto\n";
       li $v0,4
       la $a0,str_errorCol
       syscall

#         continue;  // volvemos al principio del bucle
       b while
          
#       }
if_error_columna_fin:

#
#       if (opcion == 3) {
if_cambiar:
       li $t7,3
       bne $s7,$t7,if_cambiar_fin

#         std::cout << "Nuevo valor para el elemento: ";
       li $v0,4
       la $a0,str_nuevoValor
       syscall

#         float valor;
#         std::cin >> valor;
       li $v0,6
       syscall
       mov.s $f20,$f0

#         change_elto(matTrabajo, indFil, indCol, valor);
       move $a0,$s6
       move $a1,$s1
       move $a2,$s2
       mov.s $f12,$f20
       jal change_elto

#       }
if_cambiar_fin:

#       if(opcion == 4) {
if_intercambiar: 
       li $t7,4
       bne $s7,$t7,if_intercambiar_fin

#         intercambia(matTrabajo, indFil, indCol);
       move $a0,$s6
       move $a1,$s1
       move $a2,$s2
       jal intercambia

#       }
if_intercambiar_fin:

# 
#       continue;
       b while

#     }
if_cambiar_intercambiar_fin:

# 
#    // Opción 7 ////////////////////////////////////////////////////////////
#    if(opcion == 7) {
if_encontrar_minimo:
       li $t7,7
       bne $s7,$t7,if_encontrar_minimo_fin

#       float valorMin;
#       int filaMin;
#       int columnaMin;
#       std::tie(valorMin, filaMin, columnaMin) = find_min(matTrabajo);
       move $a0,$s6
       jal find_min
       move $s4,$v0
       move $s5,$v1
       mov.s $f24,$f0
       
#       std::cout << "\nEl valor minimo esta en (" << filaMin << ','
#         << columnaMin <<") con valor " << valorMin;
       li $v0,4
       la $a0,str_valMin
       syscall
       li $v0,1
       move $a0,$s4
       syscall
       li $v0,11
       li $a0,','
       syscall
       li $v0,1
       move $a0,$s5
       syscall
       li $v0,4
       la $a0,str_conValor
       syscall
       li $v0,2
       mov.s $f12,$f24
       syscall
    
#       continue;
       b while

#     }
if_encontrar_minimo_fin:

if_sort_row_opcion:
       li $t7,8
       bne $s7,$t7,if_sort_row_opcion_fin

       li $v0,5
       syscall
       move $a1,$v0
       move $a0,$s6
       jal sort_row

       b while


if_sort_row_opcion_fin:

#
 #    // Opción Incorrecta ///////////////////////////////////////////////////////
 #    std::cout << "Error: opcion incorrecta\n";
       li $v0,4
       la $a0,str_errorOpc
       syscall

 #  }
 b while

 fin_while:

 #  std::cout << "\nTermina el programa\n";
        li $v0,4
        la $a0,str_termina
        syscall

#}
        li $v0,10
        syscall