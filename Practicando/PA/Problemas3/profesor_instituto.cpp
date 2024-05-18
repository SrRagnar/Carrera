#include <iostream>
#include <cassert>

class Racionales {
 public:
  Racionales(const int numerador = 0, const int denominador = 1) : numerador_
                            {numerador}, denominador_{denominador} {
    assert(denominador != 0);
    Simplificar();
  }
  int GetNumerador() const { return numerador_; }
  int GetDenominador() const { return denominador_; }
  void SetNumerador (int valor) { numerador_ = valor; }
  void SetDenominador (int valor) { denominador_ = valor; }
  void Simplificar ();
 private:
  int numerador_{};
  int denominador_{};
};


int CalcularMCD (int num, int den) {
  while (den != 0) {
    int temp = den;
    den = num % den;
    num = temp;
  }
  return num;
}

void Racionales::Simplificar() {
  int mcd{CalcularMCD(GetNumerador(), GetDenominador())};
  SetNumerador(GetNumerador() / mcd);
  SetDenominador(GetDenominador() / mcd);  
}

std::ostream& operator<<(std::ostream& out, const Racionales& real_a_escribir) {
  out << real_a_escribir.GetNumerador() << "/"
      << real_a_escribir.GetDenominador();  
  return out;
}

Racionales operator+(const Racionales& a, const Racionales& b) {
  Racionales resultado_suma;
  resultado_suma.SetNumerador(a.GetNumerador() * b.GetDenominador() +
                              b.GetNumerador() * a.GetDenominador());
  resultado_suma.SetDenominador(a.GetDenominador() * b.GetDenominador());
  resultado_suma.Simplificar();
  return resultado_suma;
}

Racionales operator-(const Racionales& a, const Racionales& b) {
  Racionales resultado_resta;
  resultado_resta.SetNumerador(a.GetNumerador() * b.GetDenominador() -
                              b.GetNumerador() * a.GetDenominador());
  resultado_resta.SetDenominador(a.GetDenominador() * b.GetDenominador());
  resultado_resta.Simplificar();
  return resultado_resta;
}

int main() {
  Racionales primer_racional(2, 4), segundo_racional(1, 2), tercer_racional;
  std::cout << "Los racionales son los siguientes: "
            << primer_racional << " " << segundo_racional 
            << " " << tercer_racional << std::endl;
  std::cout << "La suma de los 2 primeros es: "
            << primer_racional + segundo_racional << std::endl;
  Racionales resultado_suma {primer_racional + segundo_racional};
  return 0;
}