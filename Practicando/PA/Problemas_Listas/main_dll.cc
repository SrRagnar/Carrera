// AUTOR: 
// FECHA: 
// EMAIL: 
// VERSION: 2.0
// ASIGNATURA: Algoritmos y Estructuras de Datos
// TEMA: 4
// ESTILO: Google C++ Style Guide
// COMENTARIOS: 
// COMPILACIÓN: g++ -g main_dll.cc -o main_dll
// EJECUCIÓN: ./main_dll

#include <iostream>

#include "dll_t.h"

using namespace std;

int main(void) {
  const int n_chars{26};
  dll_t<char> lista;

  // Inserción de n_chars elementos ('a', 'b, 'c' ...) a la lista por el frente
  for (int i = 0; i < n_chars; i++) {
    cout << "Introduciendo la letra: " << (char)('a' + i) << endl;
    lista.push_front(new dll_node_t<char>('a' + i));
    // Impresión de la lista elemento a elemento
    lista.write();
    cout << endl;
  }

  // Extracción del elemento 1 por el frente
  dll_node_t<char>* nodo = lista.pop_front();
  char dato = nodo->get_data();
  delete nodo;

  // Impresión del elemento 1 extraído
  cout << "Extrae desde cabecera: " << dato << endl;

  // Extracción de elemento 2 por el frente
  nodo = lista.pop_front();
  dato = nodo->get_data();
  delete nodo;

  // Impresión del elemento 2 extraído
  cout << "Extrae desde cabecera: " << dato << endl;

  // Extracción de elemento por la cola
  nodo = lista.pop_back();
  dato = nodo->get_data();
  delete nodo;

  // Impresión del elemento extraído por la cola
  cout << "Extrae desde cola: " << dato << endl;

  // Impresión de la lista elemento a elemento
  lista.write();
  cout << endl;

  // Borrado de elemento tercero por el frente
  nodo = lista.erase(lista.get_head()->get_next()->get_next());
  dato = nodo->get_data();
  delete nodo;
  cout << "Borra tercer elemento desde frente: " << dato << endl;
  
  // Impresión de la lista elemento a elemento
  lista.write();
  cout << endl;

  // Extracción de elemento por la cola
  nodo = lista.pop_back();
  dato = nodo->get_data();
  delete nodo;

  cout << "Extrae desde cola: " << dato << endl;

  // Impresión de la lista elemento a elemento
  lista.write();
  cout << endl;

  // Obtención del nodo de la cola
  nodo = lista.get_tail();
  dato = nodo->get_data();

  cout << "Dato en la cola: " << dato << endl;

  // Impresión de la lista elemento a elemento
  lista.write();
  cout << endl;

  std::cout << "Insertar un nuevo nodo tras el tercer nodo:" << std::endl;
  nodo = lista.get_head() -> get_next() -> get_next();
  dll_node_t<char>* nuevo_nodo = new dll_node_t<char>();
  dll_node_t<char>* nuevo_nodo2 = new dll_node_t<char>();

  nuevo_nodo -> set_data('m');
  lista.InsertarTrasNodo(nuevo_nodo, nodo);
  nodo = lista.get_head();
  nuevo_nodo2 -> set_data('P');
  lista.InsertarTrasNodo(nuevo_nodo, nodo);

  lista.write();
  std::cout << std::endl;
  

  return 0;
}
