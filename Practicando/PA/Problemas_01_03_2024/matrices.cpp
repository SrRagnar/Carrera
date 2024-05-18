#include <iostream>


int main() {
  const int m{3};
  int c[m][m] = {{5, 0, 3},
                 {0, 8, 2},
                 {-3, -2, 5}};

  bool simetria = true;
  for (int i{0}; (i < m) && (simetria); ++i) {
    for (int j{0}; (j < i) && (simetria); ++j) {
      if (c[i][j] != c[j][i]) {
        simetria = false;
      }
    }
  }

  if (simetria) {
     std::cout << "La matriz es simetrica. " << std::endl;
  } else {
     std::cout << "La matriz no es simetrica. " << std::endl;
  }

   bool antisimetria = true;
  for (int i{0}; (i < m) && (antisimetria); ++i) {
    for (int j{0}; (j < i) && (antisimetria); ++j) {
      if (c[i][j] != -1 * c[j][i]) {
        antisimetria = false;
      }
    }
  }

  if (antisimetria) {
     std::cout << "La matriz es antisimetrica. " << std::endl;
  } else {
     std::cout << "La matriz no es antisimetrica. " << std::endl;
  }
    
}
