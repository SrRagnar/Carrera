// AUTOR: 
// FECHA: 
// EMAIL: 
// VERSION: 1.0
// ASIGNATURA: Algoritmos y Estructuras de Datos
// COMENTARIOS: programa de prueba del TAD cola
// Se compila con:
// g++ main_queue.cpp -o main_queue

//#include <cstdio>
#include "queue_v_t.h"
#include "queue_l_t.h"

int main(void)
{
	queue_v_t<char> cola_vector;

	for (int i = 0; i < 10; i++)
	{
		cola_vector.push('a' + i);
		cout << cola_vector;
	}

	cout << endl;

    // cola_vector.CambiarOrden();
	cola_vector.EliminarPosicionesImpares();

		
	while (!cola_vector.empty())
	{
		cout << cola_vector;
		cola_vector.pop();
	}
	
	queue_l_t<char> cola_lista;

	for (int i = 0; i < 10; i++)
	{
		cola_lista.push('a' + i);
		cout << cola_lista;
	}

	cout << endl;

	while (!cola_lista.empty())
	{
		cola_lista.pop();
		cout << cola_lista;
	}

	return 0;
}
