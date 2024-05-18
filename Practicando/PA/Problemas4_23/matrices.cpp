#include <iostream>
#include <cmath>

int main() {
  constexpr int n{9};
  int vector_enteros[n]{1, 2, 3, 4, 5, 6, 7, 8, 9};
  int cantidad_multiplos_de_3{0};
  int cantidad_no_multiplos_de_3{0};
  for (int i{0}; i < n; ++i) {
    if (vector_enteros[i] % 3 == 0) {
      ++cantidad_multiplos_de_3;
    }
    else {
      ++cantidad_no_multiplos_de_3;    
    }
  }
  std::cout << "Cantidad de multiplos de 3: " << cantidad_multiplos_de_3 << std::endl;
  std::cout << "Cantidad de no multiplos de 3: " << cantidad_no_multiplos_de_3 << std::endl;
  int *multiplos_de_3 = new int[cantidad_multiplos_de_3];
  int *no_multiplos_de_3 = new int[cantidad_no_multiplos_de_3];
  int *posiciones_multiplos_de_3 = new int[cantidad_multiplos_de_3];
  int *posiciones_no_multiplos_de_3 = new int[cantidad_no_multiplos_de_3];

int contador_posiciones_multiplo{0};
int contador_posiciones_no_multiplo{0};

  for (int i{0}; i < n; ++i) {
    if (vector_enteros[i] % 3 == 0) {
      multiplos_de_3[contador_posiciones_multiplo] = vector_enteros[i];
      ++contador_posiciones_multiplo;
    }
    else {
      no_multiplos_de_3[contador_posiciones_no_multiplo] = vector_enteros[i];
      ++contador_posiciones_no_multiplo;
    }
  }
  std::cout << "Las posiciones de los multiplos de 3 son las: ";
  for (int j{0}; j < cantidad_multiplos_de_3; ++j) {
    std::cout << multiplos_de_3[j] << " ";
  }
  std::cout << std::endl << "Los no multiplos de 3 son: ";
  for (int k{0}; k < cantidad_no_multiplos_de_3; ++k) {
    std::cout << no_multiplos_de_3[k] << " ";
  }
  std::cout << std::endl;
  double modulo_no_mult{0};
  for (int f{0}; f < cantidad_no_multiplos_de_3; ++f) {
    modulo_no_mult += (static_cast<double>(no_multiplos_de_3[f]) * static_cast<double>(no_multiplos_de_3[f]));
  }
  modulo_no_mult = pow(modulo_no_mult, 0.5);
  std::cout << "El modulo de los no multiplos es: " << modulo_no_mult << std::endl;

  delete[] multiplos_de_3;
  delete[] no_multiplos_de_3;
  delete[] posiciones_multiplos_de_3;
  delete[] posiciones_no_multiplos_de_3;
  
  return 0;
}