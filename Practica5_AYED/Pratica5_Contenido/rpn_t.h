// AUTOR: Javier Acosta Portocarrero 
// FECHA: 18/04/2024
// EMAIL: alu0101660769@ull.edu.es
// VERSION: 2.0
// ASIGNATURA: Algoritmos y Estructuras de Datos
// PRÁCTICA Nº: 5
// ESTILO: Google C++ Style Guide
// COMENTARIOS: Clase RPN (Reverse Polish Notation)

#ifndef RPNT_H_
#define RPNT_H_

#include <iostream>
#include <cctype>
#include <cmath>
//#include <cstdlib>

#include "queue_l_t.h"

// Clase RPN (Reverse Polish Notation)
template <class T> class rpn_t {
 public:
  // constructor
 rpn_t(void) : stack_() {}

  // destructor
  ~rpn_t() {}

  // operaciones
  const int evaluate(queue_l_t<char>&);

 private: 
  T stack_;
  T stack_resultados_intermedios_;
  void operate_(const char operador);
};


// operaciones
template<class T> const int rpn_t<T>::evaluate(queue_l_t<char>& q) {
  while (!q.empty()) 	{
    char c = q.front();
    
    q.pop();
    std::cout << "Sacamos de la cola un carácter: " << c;

    if (isdigit(c)) {
      int i = c - '0';
      stack_.push(i);
      // poner código
      std::cout << " (es un dígito) " << std::endl
		<< "   Lo metemos en la pila..." << std::endl;
    } else {
      std::cout << " (es un operador)" << std::endl;
      operate_(c);
      // poner código
    }
  }

  std::cout << "Resultados intermedios en orden inverso de realizacion: ";
  while (!stack_resultados_intermedios_.empty()) {
    int resultado_intermedio{stack_resultados_intermedios_.top()};
    stack_resultados_intermedios_.pop();
    std::cout << resultado_intermedio << "  ";
  }

  std::cout << std::endl;

  int resultado = stack_.top();
  return resultado;
  // poner código
}

template<class T> void rpn_t<T>::operate_(const char c) {
  assert(c == '+' || c == '-' || c == '*' || c == '/' || c == '^' || c == 'r' || c == 'l' || c == 'c');
  int resultado{0};
  if (c == '+' || c == '-' || c == '*' || c == '/' || c == '^') {
    // poner código
    int segundo_operando = stack_.top();
    stack_.pop();
    std::cout << "   Sacamos de la pila un operando: " << segundo_operando << std::endl;
  
    // poner código
    if (stack_.empty()) {
      std::cerr << "No quedan mas operandos por lo que no se puede realizar la operacion." << std::endl;
      return;
    }

    int primer_operando = stack_.top();
    stack_.pop();
    std::cout << "   Sacamos de la pila otro operando: " << primer_operando << std::endl;
  
    switch (c) {
      case '+':
        resultado = primer_operando + segundo_operando;
        break;
      case '-':
        resultado = primer_operando - segundo_operando;
        break;
      case '*':
        resultado = primer_operando * segundo_operando;
        break;
      case '/':
        if (segundo_operando == 0) {
          std::cerr << "No se puede dividir entre 0." << std::endl;
          return;
        }
        resultado = primer_operando / segundo_operando;
        break;
      case '^':
        resultado = pow(primer_operando, segundo_operando);
        break;
      // poner código resto de operadores
    }
  } else {
    int operando = stack_.top();
    stack_.pop();
    std::cout << "   Sacamos de la pila el operando: " << operando << std::endl;
    switch (c) {
      case 'r':
        resultado = sqrt(operando);
        break;
      case 'l':
        resultado = log2(operando);
        break;
      case 'c':
        resultado = operando * operando;
        break;
    }
  }

  // poner código
  stack_resultados_intermedios_.push(resultado);
  stack_.push(resultado);
  std::cout << "   Metemos en la pila el resultado: " << resultado << std::endl;
}

 
#endif  // RPNT_H_
