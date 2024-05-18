#include <iostream>

int main() {
  int numFil = 3;
  int numCol = 5;
  int mat[numFil][numCol] = {
    { 11, 12 ,13, 14, 15},
    { 21, 22, 23, 24, 25},
    { 31, 32, 33, 34, 34},
  };

  for (int f{0}; f < numFil; f++) {
    for (int c{0}; c < numCol; c++) {
        int valor = mat[f][c];
        std::cout << "\nmat[" << f << "," << c << "] = " << valor;
    }
  }
}