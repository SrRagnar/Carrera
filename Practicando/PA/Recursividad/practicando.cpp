// Mostrar una tabla binaria

#include <vector>
#include <iostream>

std::ostream& operator<<(std::ostream& out, std::vector<char> v) {
  for (int i{v.size() - 1}; i >= 0; --i) {
    out << v[i] << " ";
  }
  return out;
}

void GenerarBinario(std::vector<char> v, const int i) { // i -> nivel de la rama mas alta (altura y tamaño del vector), esta mal identado porque la posicion mas alta del arbol es 3 (ejemplo), y la posicion mas alta del vector es 2 (tamaño 3) por eso se hace i - 1 en las asginaciones para no salir de rango.
  if (i == 0) {
    std::cout << v << " ";  // El vector se muestra desde el final hasta al principio en ese orden.
  } else {
    v[i - 1] = '0';
    GenerarBinario(v, i - 1);
    v[i - 1] = '1';
    GenerarBinario(v, i - 1);
  }
} 

void GenerarBinarioPar(std::vector<char> v, const int i) { // i -> nivel de la rama mas alta (altura y tamaño del vector), esta mal identado porque la posicion mas alta del arbol es 3 (ejemplo), y la posicion mas alta del vector es 2 (tamaño 3) por eso se hace i - 1 en las asginaciones para no salir de rango.
  if (i == 0) {
    if (v[0] == '0') {
      std::cout << v << " ";  // El vector se muestra desde el final hasta al principio en ese orden.
    }
  } else {
    v[i - 1] = '0';
    GenerarBinarioPar(v, i - 1);
    v[i - 1] = '1';
    GenerarBinarioPar(v, i - 1);
  }
} 


void GenerarDecimal(std::vector<char> v, const int i) { // i -> nivel de la rama mas alta (altura y tamaño del vector), esta mal identado porque la posicion mas alta del arbol es 3 (ejemplo), y la posicion mas alta del vector es 2 (tamaño 3) por eso se hace i - 1 en las asginaciones para no salir de rango.
  if (i == 0) {
    std::cout << v << " ";  // El vector se muestra desde el final hasta al principio en ese orden.
  } else {
    v[i - 1] = '0';
    GenerarDecimal(v, i - 1);
    v[i - 1] = '1';
    GenerarDecimal(v, i - 1);
    v[i - 1] = '2';
    GenerarDecimal(v, i - 1);
    v[i - 1] = '3';
    GenerarDecimal(v, i - 1);
    v[i - 1] = '4';
    GenerarDecimal(v, i - 1);
    v[i - 1] = '5';
    GenerarDecimal(v, i - 1);
    v[i - 1] = '6';
    GenerarDecimal(v, i - 1);
    v[i - 1] = '7';
    GenerarDecimal(v, i - 1);
    v[i - 1] = '8';
    GenerarDecimal(v, i - 1);
    v[i - 1] = '9';
    GenerarDecimal(v, i - 1);
  }
} 

void EsPrimo(const unsigned int number, const int divisor) {
  if (number == divisor) {
    return true;
  } else if (number % divisor == 0) {
    return false;
  } else {
    EsPrimo (number, divisor + 1);
  }
}

void MaximoComunDivisor();

int main() {
  std::vector<char> v;
  int tamano = 3;
  v.resize(3);
  GenerarDecimal(v, 3);
  std::cout << std::endl;
  return 0;
}