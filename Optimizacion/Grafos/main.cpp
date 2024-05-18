 /*
 *  Programa principal.
 *
 *
 *               Autores : Javier Acosta Portocarrero
 *               Cursos  : 2023-2024
 */

#include <string.h>
#include "grafo.h"


void menu (unsigned dirigido, char &opcion)
//Expresion del menu de opciones segun sea un grafo dirigido o no dirigido
{
    cout << "Optimiza!cion en Grafos, 2023-2024 Javier Acosta Portocarrero" << endl;
    cout << "c. [c]argar grafo desde fichero" << endl;
    if (dirigido == 0) //Grafo no dirigido
            {
            cout << "i. Mostrar [i]nformacion basica del grafo" << endl;
            cout << "a. Mostrar la lista de [a]dyacencia del grafo" << endl;
            std::cout << "m. Realizar un recorrido en a[m]plitud del grafo desde un nodo" << std::endl;
            std::cout << "r. Realizar un recorrido en p[r]ofundidad del grafo desde un nodo" << std::endl;
	    //Aqu� se a�aden m�s opciones al men� del grafo no dirigido
            }
    else
            {
            cout << "i. Mostrar [i]nformacion basica del grafo" << endl;
            cout << "s. Mostrar la lista de [s]ucesores del grafo" << endl;
            cout << "p. Mostrar la lista de [p]redecesores del grafo" << endl;
            std::cout << "m. Realizar un recorrido en a[m]plitud del grafo desde un nodo por sucesores" << std::endl;
            std::cout << "r. Realizar un recorrido en p[r]ofundidad del grafo desde un nodo por sucesores" << std::endl;
	    //Aqu� se a�aden m�s opciones al men� del grafo dirigido
            };
    cout << "q. Finalizar el programa" << endl;
    cout << "Introduce la letra de la accion a ejecutar  > ";
    cin >> opcion;
};
// El principal es simplemente un gestor de menu, diferenciando acciones para dirigido y para no dirigido, y un men� inicial si no hay un grafo cargado
int main(int argc, char *argv[])
{
    char borrar;
    int error_apertura;
    char nombrefichero[85], opcion;
    system("clear");
    //Si tenemos el nombre del primer fichero por argumento, es una excepcion, y lo intentamos cargar, si no, lo pedimos desde teclado
    if (argc > 1) {
      std::cout << "Cargando datos desde el fichero dado como argumento" << std::endl;
      strcpy(nombrefichero, argv[1]);
    } else {
      cout << "Introduce el nombre completo del fichero de datos" << endl;
      cin >> nombrefichero;
    }
    GRAFO G(nombrefichero, error_apertura);
    if (error_apertura == 1)
    {
        cout << "Error en la apertura del fichero desde argumento: revisa nombre y formato" << endl;
        std::cout << "Pulse enter para continuar .....";
        std::cin.ignore();
        std::cin.get();
        system("clear");
    }
    else
    {
        cout << "Grafo cargado desde el fichero " << nombrefichero << endl;
        std::cout << "Pulse enter para continuar .....";
        std::cin.ignore(); 
        std::cin.get();
        system("clear");
        do
        {
            menu(G.Es_dirigido(), opcion);
            switch (opcion)
            {
                case 'c' :
                   system("clear");
         	         cout << "Introduce el nombre completo del fichero de datos" << endl;
                    cin >> nombrefichero;
                    G.actualizar(nombrefichero, error_apertura);
                    if (error_apertura == 1)
                    {
                        cout << "Error en la apertura del fichero: revisa nombre y formato : puedes volver a intentarlo" << endl;
                    }
                    else
                    {
                        cout << "Fichero cargado correctamente desde " << nombrefichero << endl;
                    }
                    std::cout << "Pulse enter para continuar .....";
                    std::cin.ignore(); 
                    std::cin.get();
                    system("clear");
                    break;

                case 'i' :
                    system("clear");
		                cout << "Grafo cargado desde " << nombrefichero << endl;
                    cout << "Informacion basica del grafo:" << std::endl;
                    G.Info_Grafo();
                    std::cout << "Pulse enter para continuar .....";
                    std::cin.ignore(); 
                    std::cin.get();
                    system("clear");
                    break;

                case 's' :
                  system("clear");
                  G.Mostrar_Listas(-1);
                  std::cout << "Pulse enter para continuar .....";
                  std::cin.ignore(); 
                  std::cin.get();
                  system("clear");
                  break;

                case 'p' :
                  system("clear");
                  G.Mostrar_Listas(1);
                  std::cout << "Pulse enter para continuar .....";
                  std::cin.ignore(); 
                  std::cin.get();
                  system("clear");
                  break;

                case 'a' :
                  system("clear");
                  G.Mostrar_Listas(0);
                  std::cout << "Pulse enter para continuar .....";
                  std::cin.ignore(); 
                  std::cin.get();
                  system("clear");
                  break;

                case 'm' :
                  system("clear");
                  G.RecorridoAmplitud();
                  std::cout << "Pulse enter para continuar .....";
                  std::cin.ignore(); 
                  std::cin.get();
                  system("clear");
                  break;

                case 'r' :
                  system("clear");
                  G.RecorridoProfundidad();
                  std::cout << "Pulse enter para continuar .....";
                  std::cin.ignore(); 
                  std::cin.get();
                  system("clear");
                  break;

                default :
                  break;
		 //Situar aqu� el resto de opciones del men�
            }
    }
    while (opcion != 'q');
    }
    std::cout << "Fin del programa" << std::endl;
	  return 0;
}
