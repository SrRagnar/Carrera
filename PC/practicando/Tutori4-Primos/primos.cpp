// 1. Pedir entero al usuario (n)
// 2. Si n es 0 terminar.
// 3. Probar desde el 2 hasta el n-1 si es divisible
// 4. Si se encontró divisible mostrar el encontrado.
// 5. Caso contrario decir que es primo
// 6. Volver al punto 1.

#include <iostream>



int main() {
  std::cout << "Este programa calcula si un numero es primo o no." << std::endl;
  int numero_a_probar{1};
  while (numero_a_probar != 0) {
    std::cout << "Escribe un numero entero (0 para salir): ";
    std::cin >> numero_a_probar;
    if (numero_a_probar == 0) {
      break;
    }
    int contador_divisores{0};
    for (int i{2}; (i < numero_a_probar) && (contador_divisores == 0); ++i) {
      if (!(numero_a_probar % i)) {
        ++contador_divisores;
        std::cout << "El divisor mas pequeño es: " << i;
      }
    }
    if (contador_divisores == 0) {
      std::cout << "El numero " << numero_a_probar << " es primo.";
    }
    std::cout << std::endl;
  }
}