// AUTOR: Javier Acosta Portocarrero
// FECHA: 03/04/2024
// EMAIL: alu0101660769@ull.edu.es
// VERSION: 1.0
// ASIGNATURA: Algoritmos y Estructuras de Datos
// PRÁCTICA Nº: 4
// ESTILO: Google C++ Style Guide
// COMENTARIOS: Practica sobre lista enlazadas
// 

#ifndef SLLPOLYNOMIAL_H_
#define SLLPOLYNOMIAL_H_

#include <iostream>
#include <math.h>  // fabs, pow

#include "pair_t.h"
#include "sll_t.h"
#include "vector_t.h"

#define EPS 1.0e-6

typedef pair_t<double> pair_double_t;  // Campo data_ de SllPolynomial
typedef sll_node_t<pair_double_t> SllPolyNode;  // Nodos de SllPolynomial

// Clase para polinomios basados en listas simples de pares
class SllPolynomial : public sll_t<pair_double_t> {
 public:
  // constructores
  SllPolynomial(void) : sll_t() {};
  SllPolynomial(const vector_t<double>&, const double = EPS);

  // destructor
  ~SllPolynomial() {};

  // E/S
  void Write(std::ostream& = std::cout) const;
  
  // operaciones
  double Eval(const double) const;
  bool IsEqual(const SllPolynomial&, const double = EPS) const;
  void Sum(const SllPolynomial&, SllPolynomial&, const double = EPS);

  // Modificacion

  double EvalGrado(const double x, int grado) const;
};


bool IsNotZero(const double val, const double eps = EPS) {
  return fabs(val) > eps;
}

// FASE II
// constructor
SllPolynomial::SllPolynomial(const vector_t<double>& v, const double eps) {
  for (int i{v.get_size() - 1}; i >= 0; --i) {
    if (IsNotZero(v[i], eps)) {
      pair_double_t monomio_temporal;
      monomio_temporal.set(v[i], i);
      SllPolyNode* nodo_temp = new SllPolyNode(monomio_temporal);
      push_front(nodo_temp);
      }
    }
  }

/* SllPolynomial::SllPolynomial(const vector_t<double>& v, const double eps) {
  // poner el código aquí
  SllPolyNode* cabecera = new SllPolyNode();
  push_front(cabecera);
  SllPolyNode* aux = get_head();
  for (int i{0}; i < v.get_size(); ++i) {
    if (fabs(v[i]) >= eps) {
      SllPolyNode* temp = new SllPolyNode();
      pair_double_t monomio_temporal;
      monomio_temporal.set(v[i], i);
      temp -> set_data(monomio_temporal);
      aux -> set_next(temp);
      aux = temp;
    }
  }
}
*/


// E/S
void SllPolynomial::Write(std::ostream& os) const {
  os << "[ ";
  bool first{true};
  SllPolyNode* aux{get_head()};
  while (aux != NULL) {
    int inx{aux->get_data().get_inx()};
    double val{aux->get_data().get_val()};
    if (val > 0)
      os << (!first ? " + " : "") << val;
    else
      os << (!first ? " - " : "-") << fabs(val);
    os << (inx > 1 ? " x^" : (inx == 1) ? " x" : "");
    if (inx > 1)
      os << inx;
    first = false;
    aux = aux->get_next();
  }
  os << " ]" << std::endl;
}

std::ostream& operator<<(std::ostream& os, const SllPolynomial& p) {
  p.Write(os);
  return os;
}


// Operaciones con polinomios

// FASE III
// Evaluación de un polinomio representado por lista simple
double SllPolynomial::Eval(const double x) const {
  double result{0.0};
  SllPolyNode* aux = get_head(); 
  while (aux != NULL) {
    result += aux -> get_data().get_val() * pow(x, aux -> get_data().get_inx());
    aux = aux -> get_next();
  }
  // poner el código aquí
  
  return result;
}

// Comparación si son iguales dos polinomios representados por listas simples
bool SllPolynomial::IsEqual(const SllPolynomial& sllpol,
			    const double eps) const {
  bool differents = false;
  SllPolyNode* aux1 = get_head();
  SllPolyNode* aux2 = sllpol.get_head();
  while (aux1 != NULL) {
    if (aux2 == NULL) {
      differents = true;
      return !differents;  
    }
    if ((aux1 -> get_data().get_val() != aux2 -> get_data().get_val()) || (aux1 -> get_data().get_inx() != aux2 -> get_data().get_inx())) {
      differents = true;
      return !differents;
    }
    aux1 = aux1 -> get_next();
    aux2 = aux2 -> get_next();
  }
  return !differents;
}

// FASE IV
// Generar nuevo polinomio suma del polinomio invocante mas otro polinomio
void SllPolynomial::Sum(const SllPolynomial& sllpol,
			SllPolynomial& sllpolsum,
			const double eps) {
  SllPolyNode* aux1 = get_head();
  SllPolyNode* aux2 = sllpol.get_head();
  SllPolyNode* aux3;
  bool first = true;
  while (aux1 != NULL && aux2 != NULL) {
    pair_double_t monomio_temp;
    SllPolyNode* nodo_temp;
    if (aux1 -> get_data().get_inx() != aux2 -> get_data().get_inx()) {
      if (aux1 -> get_data().get_inx() > aux2 -> get_data().get_inx()) {
        monomio_temp.set(aux2 -> get_data().get_val(), aux2 -> get_data().get_inx());
        if (first) {
          nodo_temp = new SllPolyNode(monomio_temp);
          sllpolsum.push_front(nodo_temp);
          aux3 = sllpolsum.get_head();
          first = false;
        } else {
          nodo_temp = new SllPolyNode(monomio_temp);
          aux3 -> set_next(nodo_temp);
          aux3 = nodo_temp;
        }
        aux2 = aux2 -> get_next();
      } else {
        monomio_temp.set(aux1 -> get_data().get_val(), aux1 -> get_data().get_inx());
       if (first) {
          nodo_temp = new SllPolyNode(monomio_temp);
          sllpolsum.push_front(nodo_temp);
          aux3 = sllpolsum.get_head();
          first = false;
        } else {
          nodo_temp = new SllPolyNode(monomio_temp);
          aux3 -> set_next(nodo_temp);
          aux3 = nodo_temp;
        }
        aux1 = aux1 -> get_next();     
      } 
    } else {
      double suma{(aux1 -> get_data().get_val()) + (aux2 -> get_data().get_val())};
      if (IsNotZero(suma, eps)) {
        monomio_temp.set(suma, aux1 -> get_data().get_inx());
        if (first) {
          nodo_temp = new SllPolyNode(monomio_temp);
          sllpolsum.push_front(nodo_temp);
          aux3 = sllpolsum.get_head();
          first = false;  
        } else {
          nodo_temp = new SllPolyNode(monomio_temp);
          aux3 -> set_next(nodo_temp);
          aux3 = nodo_temp;
        }
      } 
      aux2 = aux2 -> get_next();
      aux1 = aux1 -> get_next();
    }
  }
  
  while (aux1 != NULL) {
    pair_double_t monomio_temp;
    monomio_temp.set(aux1 -> get_data().get_val(), aux1 -> get_data().get_inx());
    SllPolyNode* nodo_temp = new SllPolyNode(monomio_temp);
    aux3 -> set_next(nodo_temp);
    aux3 = nodo_temp;
    aux1 = aux1 -> get_next();
  }

  while (aux2 != NULL) {
    pair_double_t monomio_temp;
    monomio_temp.set(aux2 -> get_data().get_val(), aux2 -> get_data().get_inx());
    SllPolyNode* nodo_temp = new SllPolyNode(monomio_temp);
    aux3 -> set_next(nodo_temp);
    aux3 = nodo_temp;
    aux2 = aux2 -> get_next();
  }
}


// Modificacion

double SllPolynomial::EvalGrado(const double x, int grado) const {
  double resultado_evaluacion{0};
  SllPolyNode* nodo_auxiliar = get_head();
  while (nodo_auxiliar != NULL) {
    if (nodo_auxiliar -> get_data().get_inx() == grado) {
      resultado_evaluacion = nodo_auxiliar -> get_data().get_val() * pow(x, nodo_auxiliar -> get_data().get_inx());
      break;
    }
    nodo_auxiliar = nodo_auxiliar -> get_next();
  }
  return resultado_evaluacion;
}

#endif  // SLLPOLYNOMIAL_H_
