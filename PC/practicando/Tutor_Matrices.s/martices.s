# La memoria se divide en grandes espacios para las filas y cada espacio de fila se divide 
# en otro espacios mas pequeños para cada variable (ya sea double, int ...) siendo estas una columna de la fila

# Lo que se hace es que se da la direccion de la fila (teniendo cada fila un tamaño dependiendo 
# de sus componentes y la cantidad de columnas) y despues se le suma otro desplazamiento para llegar 
# a la columna deseada de esa fila (teniendo cada columna el tamaño del tipo de variable)

sizeW = 4   # tamaño de un entero

# #include <iostream>
# Tabla aignacion de variables a regstros
# numFil -> $s0
# numCol -> $s1
# mat -> $s3
# f -> $s4
# c -> $s5
# valor -> $s6

# int main() {
main: 

#   int numFil = 3;
li $s0,3

#   int numCol = 5;
li $s1,5

#   int mat[numFil][numCol] = {
#     { 11, 12 ,13, 14, 15},
#     { 21, 22, 23, 24, 25},
#     { 31, 32, 33, 34, 34},
#   };
# 
#   for (int f{0}; f < numFil; f++) {
#     for (int c{0}; c < numCol; c++) {
#         int valor = mat[f][c];
          mul  $t0,$s4,$s1   # f * numCol
          addu $t0,$t0,$s5  # f * numCol + c
          mul $t0,$t0,sizew  # (f * numCol + c) * tamElem
          addu $t0,$s3,$t0  # dirBase + (f * numCol + c) * tamElem

          lw  $s6,0($t0)

#         std::cout << "\nmat[" << f << "," << c << "] = " << valor;
#     }
#   }
# }