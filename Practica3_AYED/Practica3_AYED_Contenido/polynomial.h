// AUTOR: 
// FECHA: 
// EMAIL: 
// VERSION: 1.0
// ASIGNATURA: Algoritmos y Estructuras de Datos
// PRÁCTICA Nº: 3
// ESTILO: Google C++ Style Guide
// COMENTARIOS:
// 

#ifndef POLYNOMIAL_H_
#define POLYNOMIAL_H_

#include <iostream>
#include <math.h>  // fabs, pow

#include "vector_t.h"
#include "sparse_vector_t.h"

// Clase para polinomios basados en vectores densos de doubles
class Polynomial : public vector_t<double> {
 public:
  // constructores
  Polynomial(const int n = 0) : vector_t<double>(n) {};
  Polynomial(const Polynomial& pol)
      : vector_t<double>(pol) {}; // constructor de copia

  // destructor
  ~Polynomial() {};

  // E/S
  void Write(std::ostream& = std::cout, const double eps = EPS) const;
  
  // operaciones
  double Eval(const double) const;
  bool IsEqual(const Polynomial&, const double = EPS) const;
 };


// Clase para polinomios basados en vectores dispersos
class SparsePolynomial : public sparse_vector_t {
 public:
  // constructores
  SparsePolynomial(const int n = 0) : sparse_vector_t(n) {};
  SparsePolynomial(const Polynomial& pol) : sparse_vector_t(pol) {};
  SparsePolynomial(const SparsePolynomial&);  // constructor de copia

  // destructor
  ~SparsePolynomial() {};

  // Modificacion
  void MostrarMonomiosNulos(const double = EPS) const;

  // E/S
  void Write(std::ostream& = std::cout) const;
  
  // operaciones
  double Eval(const double valor) const;
  bool IsEqual(const SparsePolynomial&, const double = EPS) const;
  bool IsEqual(const Polynomial&, const double = EPS) const;
};

// E/S
void Polynomial::Write(std::ostream& os, const double eps) const {
  os << get_size() << ": [ ";
  bool first{true};
  for (int i{0}; i < get_size(); i++)
    if (IsNotZero(at(i), eps)) {
      os << (!first ? " + " : "") << at(i)
	 << (i > 1 ? " x^" : (i == 1) ? " x" : "");
      if (i > 1)
	os << i;
      first = false;
    }
  os << " ]" << std::endl;
}


std::ostream& operator<<(std::ostream& os, const Polynomial& p) {
  p.Write(os);
  return os;
}

// Operaciones con polinomios

// Evaluación de un polinomio representado por vector denso
double Polynomial::Eval(const double x) const {
  double result{0.0};
  for (int i{0}; i < get_size(); ++i) {
    result += at(i) * pow(x, i);
  }
  return result;
}

// Comparación si son iguales dos polinomios representados por vectores densos
bool Polynomial::IsEqual(const Polynomial& pol, const double eps) const {
  bool differents = false;
  int menor_tamano(0);
  if (get_size() == pol.get_size()) {
    menor_tamano = get_size();
  } else if (get_size() < pol.get_size()) {
    menor_tamano = get_size();
    for (int j{menor_tamano}; j < pol.get_size(); ++j) {
      if (fabs(pol[j]) >= eps) {
        differents = true;
      }
    }
  } else {
    menor_tamano = pol.get_size();
    for (int j{menor_tamano}; j < get_size(); ++j) {
      if (fabs(at(j)) >= eps) {
        differents = true;
      }
    }
  }

  for (int i{0}; i < menor_tamano; ++i) {
    if (at(i) != pol[i]) {
      differents = true;
    }
  }
  // poner el código aquí
  return !differents;
}

// constructor de copia
SparsePolynomial::SparsePolynomial(const SparsePolynomial& spol) {
  *this = spol;   // se invoca directamente al operator=
}

// E/S
void SparsePolynomial::Write(std::ostream& os) const {
  os << get_n() << "(" << get_nz() << "): [ ";
  bool first{true};
  for (int i{0}; i < get_nz(); i++) {
    int inx{at(i).get_inx()};
    os << (!first ? " + " : "") << at(i).get_val()
       << (inx > 1 ? " x^" : (inx == 1) ? " x" : "");
    if (inx > 1)
      os << inx;
    first = false;
  }
  os << " ]" << std::endl;
}

std::ostream& operator<<(std::ostream& os, const SparsePolynomial& p) {
  p.Write(os);
  return os;
}

// Operaciones con polinomios

// Evaluación de un polinomio representado por vector disperso
double SparsePolynomial::Eval(const double x) const {
  double result{0.0};
  for (int i{0}; i < get_nz(); ++i) {
    result += at(i).get_val() * pow(x, at(i).get_inx());
  }
  // poner el código aquí
  return result;
}

// Comparación si son iguales dos polinomios representados por vectores dispersos
bool SparsePolynomial::IsEqual(const SparsePolynomial& spol
			       , const double eps) const {
  bool differents = false;
  if (get_nz() != spol.get_nz()) {
    differents = true;
    return !differents;
  }
  for (int i{0}; i < get_nz(); ++i) {
    if (at(i).get_inx() != spol[i].get_inx()) {
      differents = true;
    } else if (at(i).get_val() != spol[i].get_val()) {
        differents = true;
    }
  }
  // poner el código aquí
  return !differents;
}

// Comparación si son iguales dos polinomios representados por
// vector disperso y vector denso
bool SparsePolynomial::IsEqual(const Polynomial& pol, const double eps) const {
  bool differents = false;
  for (int i{0}; i < get_nz(); ++i) {
    if (at(i).get_val() != pol[at(i).get_inx()]) {
      differents = true;
    }
  }
  // El if de abajo sirve para comprobar que el vector denso no 
  // tiene valores no nulos en posiciones distintas al disperso.
  if (Eval(2) != pol.Eval(2)) {
    differents = true;
  } 
  // poner el código aquí
  return !differents;
}

// Modificacion

void SparsePolynomial::MostrarMonomiosNulos(const double epsilon) const {
  std::cout << "los monomios cuyos coeficientes son 0 son: ";
  int posiciones_disperso{0};
  bool first{true};
  for (int i{0}; i < get_n(); ++i) {
    if (at(posiciones_disperso).get_inx() == i) {
      if (posiciones_disperso < get_nz() - 1) {
        ++posiciones_disperso;
      }
    } else {
      std::cout << (!first ? " + " : "") << 0
                << (i > 1 ? " x^" : (i == 1) ? " x" : "");
      if (i > 1) {
        std::cout << i;
      }
      first = false;   
    }
  }
  std::cout << std::endl;
}


#endif  // POLYNOMIAL_H_
