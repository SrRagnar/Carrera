 /*
 *  GRAFO.CPP - Plantilla para la implementaci�n de la clase GRAFOS
 *
 *
 *  Autores : Javier Acosta Portocarrero
 *  Cursos   : 2023-2024
 */

#include "grafo.h"

void GRAFO :: destroy()
{
	for (unsigned i=0; i< n; i++)
    {
		LS[i].clear();
		//A[i].clear();
		if (dirigido == 1)
        {
            LP[i].clear();
        };
	}
	LS.clear();
	LP.clear();
	A.clear();

}

void GRAFO :: build (char nombrefichero[85], int &errorapertura)
{
  ElementoLista     dummy;
	ifstream textfile;
	textfile.open(nombrefichero);
	if (textfile.is_open())
    {
		unsigned i, j, k;
    int peso_minimo{maxint};  
		// leemos por conversion implicita el numero de nodos, arcos y el atributo dirigido
		textfile >> (unsigned &) n >> (unsigned &) m >> (unsigned &) dirigido;
		// los nodos internamente se numeran desde 0 a n-1
		// creamos las n listas de sucesores
		LS.resize(n);
    if (Es_dirigido()) {
      LP.resize(n);
    }
        // leemos los m arcos
		for (k=0;k<m;k++)
        	{
			textfile >> (unsigned &) i  >> (unsigned &) j >> (int &) dummy.c; // i es el nodo , j es el nodo predecesor, sucesor o adyacente de i y c el coste de la union.
            dummy.j = j - 1; // usamos dummy cono auxiliar y se resta 1 porque el nodo 1 es la posicion 0 del vector.
            LS[i - 1].push_back(dummy);
            if (Es_dirigido()) {
              if (dummy.c < peso_minimo) {
                peso_minimo = dummy.c;
              }
              dummy.j = i - 1 ; // añadimos el predecesor
              LP[j - 1].push_back(dummy);
            } else {
              dummy.j = i - 1;
              LS[j - 1].push_back(dummy);

            }
			//damos los valores a dummy.j y dummy.c
			//situamos en la posicion del nodo i a dummy mediante push_back
			//pendiente de hacer un segundo push_back si es no dirigido. O no.
			//pendiente la construccion de LP, si es dirigido
			//pendiente del valor a devolver en errorapertura
			//...
            }
            peso_minimo_ = peso_minimo;
            errorapertura = 0;

    } else {
      errorapertura = 1;
    }
      textfile.close();
}

GRAFO::~GRAFO()
{
	destroy();
}

GRAFO::GRAFO(char nombrefichero[85], int &errorapertura)
{
	build (nombrefichero, errorapertura);
}

void GRAFO:: actualizar (char nombrefichero[85], int &errorapertura)
{
    //Limpiamos la memoria dinamica asumida en la carga previa, como el destructor
    destroy();
    //Leemos del fichero y actualizamos G con nuevas LS y, en su caso, LP
    build(nombrefichero, errorapertura);
}

unsigned GRAFO::Es_dirigido()
{
  unsigned es_dirigido;
  if (dirigido) {
    es_dirigido = 1;
  } else {
    es_dirigido = 0;
  }
  return es_dirigido;
}

void GRAFO::Info_Grafo()
{
  std::cout << "El numero de nodos en el grafo es de " << n << ", por lo tanto este es de orden " << n << std::endl ;
  std::cout << "La cantidad de arcos del grafo es de: " << m << std::endl;
  if (Es_dirigido()) {
    std::cout << "El grafo es dirigido." << std::endl;
  } else {
    std::cout << "El grafo no es dirigido." << std::endl;
  }
}

void  Mostrar_Lista(vector<LA_nodo> L)
{
  bool first = true;
  for (int i{0}; i < L.size(); ++i) {
    if (first) {
      first = false;
    } else {
      std::cout << std::endl;
    }
    std::cout << "Las conexiones de la lista deseada del nodo [" << i + 1 << "] con sus costes son: ";
    unsigned int contador{0};
    for (int j{0}; j < L[i].size(); ++j) {
      std::cout << "[" << L[i][j].j + 1 << "] con coste = " << L[i][j].c << " ";
      ++contador;
    }
    if (contador == 0) {
      std::cout << "No tiene ninguna conexion deseada.";
    }
  }
  std::cout << std::endl;
}

void GRAFO :: Mostrar_Listas (int l)
{
  if (Es_dirigido()) {
    if (l == -1) {
      std::cout << "A continuacion se mostraran las listas de sucesores de los nodos del grafo:" << std::endl << std::endl;
      Mostrar_Lista(LS);
    } else if (l == 1) {
      std::cout << "A continuacion se mostraran las listas de predecesores de los nodos del grafo:" << std::endl << std::endl;
      Mostrar_Lista(LP);
    } else {
      std::cout << "Opcion no valida." << std::endl;
    }
  } else {
    if (l == 0) {
      std::cout << "A continuacion se mostraran las listas de adyacencia de los nodos del grafo:" << std::endl << std::endl;
      Mostrar_Lista(LS);
    } else {
      std::cout << "Opcion no valida." << std::endl << std::endl;
    }
  }
}

void GRAFO::Mostrar_Matriz() //Muestra la matriz de adyacencia, tanto los nodos adyacentes como sus costes
{

}

void GRAFO::dfs_num(unsigned i, vector<LA_nodo>  L, vector<bool> &visitado, vector<unsigned> &prenum, unsigned &prenum_ind, vector<unsigned> &postnum, unsigned &postnum_ind) //Recorrido en profundidad recursivo con recorridos enum y postnum
{
	visitado[i] = true;
    prenum[prenum_ind++]=i;//asignamos el orden de visita prenum que corresponde el nodo i
    for (unsigned j=0;j<L[i].size();j++)
             if (!visitado[L[i][j].j])
                {
                dfs_num(L[i][j].j, L, visitado, prenum, prenum_ind, postnum, postnum_ind);
                };
    postnum[postnum_ind++]=i;//asignamos el orden de visita posnum que corresponde al nodo i
}

void GRAFO::RecorridoProfundidad()  // Siempre que se puede seguir avanzando en el grafo lo haremos y despues ya volvemos hacia atras si no hay mas camino.
{
  vector<bool> visitado;
  visitado.resize(n, false); // Inicializamos el vector de visita de los nodos, el segundo parametro es con los que se inicializan las posiciones del vector.

  vector<unsigned> prenum;
  prenum.resize(n, 0);  // Inicializamos prenum
  vector<unsigned> postnum;
  postnum.resize(n, 0);

  unsigned prenum_indice = 0;
  unsigned postnum_indice = 0;  // Inicializamos los indices a 0

  unsigned i;  // No se si este es el tipo de variable
  cout << "Elije el nodo de partida [1 - " << n << "]: ";
  cin >> (unsigned&)i;  // Leemos el nodo de partida

  dfs_num(i - 1, LS, visitado, prenum, prenum_indice, postnum, postnum_indice); // Se realiza el recorrido en profundidad, se le resta 1 a i por las posiciones de los vectore

  // Ahora habria que mostrar por pantalla postnum y prenum TERMINAR EN CASA

  std::cout << "Orden de visita de los nodos en preorden:" << std::endl;

  for (int i{0}; i < prenum_indice; ++i) {
    std::cout << " [" << prenum[i] + 1 << "] ";
    if (i < prenum_indice - 1) {
      std::cout << "-->";
    } 
  }
  std::cout << endl;

  std::cout << "Orden de visita de los nodos en postorden:" << std::endl;

  for (int i{0}; i < postnum_indice; ++i) {
    std::cout << " [" << postnum[i] + 1 << "] ";
    if (i < postnum_indice - 1) {
      std::cout << "-->";
    } 
  }
  std::cout << endl;
}

void GRAFO::bfs_num(	unsigned i, //nodo desde el que realizamos el recorrido en amplitud
				vector<LA_nodo>  L, //lista que recorremos, LS o LP; por defecto LS
				vector<unsigned> &pred, //vector de predecesores en el recorrido
				vector<unsigned> &d) //vector de distancias a nodo i+1
//Recorrido en amplitud con la construcci�n de pred y d: usamos la cola
{
    vector<bool> visitado; //creamos e iniciamos el vector visitado
    visitado.resize(n, false);
    visitado[i] = true;

    pred.resize(n, 0); //creamos e inicializamos pred y d
    d.resize(n, 0);
    pred[i] = i;
    d[i] = 0;

    queue<unsigned> cola; //creamos e inicializamos la cola
    cola.push(i);//iniciamos el recorrido desde el nodo i+1

    while (!cola.empty()) //al menos entra una vez al visitar el nodo i+1 y contin�a hasta que la cola se vac�e
    {   unsigned K = cola.front(); //cogemos el nodo k+1 de la cola. El primer elemento de la cola
        cola.pop(); //lo sacamos de la cola. Sacamos k de la cola
        //Hacemos el recorrido sobre L desde el nodo k+1
        for (unsigned j=0;j<L[K].size();j++)
            //Recorremos todos los nodos u adyacentes al nodo k+1
            //Si el nodo u no esta visitado
            {
                if (visitado[L[K][j].j] == false) {  // Visitamos el nodo j si no se ha visitado
                    visitado[L[K][j].j] = true;  // Definimos que ya lo hemos visitado
                    pred[L[K][j].j] = K;  // Definimos k como predecesor de j
                    cola.push(L[K][j].j); //Metemos el nodo k en la cola
                    d[L[K][j].j] = d[K] + 1;  // Definimos la distancia de j al nodo inicial;
                } 
            //Lo visitamos
            //Lo metemos en la cola
            //le asignamos el predecesor
            //le calculamos su etiqueta distancia
            };
        //Hemos terminado pues la cola esta vacia
    };
}

void GRAFO::RecorridoAmplitud() //Construye un recorrido en amplitud desde un nodo inicial. Esto es lo que hicimos en una tabla en la clase de teoria (con las distancia y esas cosas)
{
  vector<bool> visitado;
  visitado.resize(n, false); 

  vector<unsigned> pred;
  pred.resize(n, 0);  
  vector<unsigned> d;
  d.resize(n, 0);

  unsigned prenum_indice = 0;
  unsigned postnum_indice = 0; 

  unsigned i;  // No se si este es el tipo de variable
  cout << "Elije el nodo de partida [1 - " << n << "]: ";
  cin >> (unsigned&)i;  // Leemos el nodo de partida
  std::cout << "Nodo inicial: " << i << std::endl;
  
  bfs_num(i - 1, LS, pred, d); // Se realiza el recorrido en amplitud

  std::cout << "Nodos segun distancia al nodo inicial en numero de aristas" << std::endl;
  std::cout << "Distancia 0 aristas : " << i << std::endl;
  
  int distancia_maxima{0};
  for (int j{0}; j < d.size(); ++j) {
    if (d[j] > distancia_maxima) {
      distancia_maxima = d[j];
    }
  }
  
  for (int j{1}; j <= distancia_maxima; ++j) {
    std::cout << "Distancia " << j << " aristas ";
    for (int k{0}; k < d.size(); ++k) {
      if (d[k] == j) {
        std::cout << ": " << k + 1 << " ";
      }
    }
    std::cout << std::endl;
  }

  std::cout << std::endl << "Ramas de conexion en el recorrido" << std::endl;

  for (int j{1}; j <= distancia_maxima; ++j) {
    for (int k{0}; k < d.size(); ++k) {
      if (d[k] == j) {
        std::cout << i;
        std::vector<unsigned> rama_auxiliar;
        unsigned aux = k;
        for (int l{0}; l < j; ++l) {
          rama_auxiliar.emplace_back(aux);
          aux = pred[aux];
        }
        for (int l{static_cast<int>(rama_auxiliar.size() - 1)}; l >= 0; --l) {
          std::cout << " - " << rama_auxiliar[l] + 1 << " ";
        }
        std::cout << std::endl;
      }
    }
  }
}

void GRAFO::Kruscal() {
  vector <AristaPesada> Aristas;
  Aristas.resize(m);

  unsigned k = 0;

  for (unsigned i = 0; i < n; i++) {
    for (unsigned j = 0; j < LS[i].size(); j++) {
      if (i < LS[i][j].j) {
      Aristas[k].extremo1 = i;
      Aristas[k].extremo2 = LS[i][j].j;
      Aristas[k++].peso = LS[i][j].c;
      }
    }
  }
    
  unsigned head = 0;  // Posicion de la arista de menor coste en cada iteracion
  unsigned cont = 0;  // Contador de aristas insertadas en el MST
  unsigned pesoMST = 0;  // Coste del MST

  vector<unsigned> Raiz;
  Raiz.resize(n);

  for (unsigned i{0}; i < n; i++) {
    Raiz[i] = i;  
  }

  AristaPesada AristaTemp;

  do {
    if (head < m - 1) { 
      // Bucle para garantizar que head es la arista con menor peso que no se haya usado aun , los mas 
      // livianos quedan en la posicion mas baja del vector, por eso usamos head + 1 para no repetir aristas ya incluidas en kruskal
      for (unsigned i = head + 1; i < m; ++i) {
        if (Aristas[i].peso < Aristas[head].peso) {
          AristaPesada temp = Aristas[i];
          Aristas[i] = Aristas[head];
          Aristas[head] = temp;
        }
      }
    }

    if (Raiz[Aristas[head].extremo1] != Raiz[Aristas[head].extremo2]) {
      // kill = Raiz[Aristas[head].extremo1];
      unsigned kill = Raiz[Aristas[head].extremo1];  
      //para todo nodo k desde 0 hasta n - 1, hacer
      for (int k{0}; k < n; k++) {
        if (Raiz[k] == kill) {
          // si raiz[k] = kill entonces raiz[k] = Raiz[Aristas[head].extremo2];
          Raiz[k] = Raiz[Aristas[head].extremo2];
        } 
      }
  
      cont++;

      cout << "Arista numero " << cont << " incorporada (" << Aristas[head].extremo1 + 1 << ", " 
           << Aristas[head].extremo2 + 1 << "), con peso " <<  Aristas[head].peso << std::endl;

      pesoMST += Aristas[head].peso;
    }
    
    head++;  

  } while ((cont < (n - 1)) && (head < m));

  if (cont < (n - 1)) {
    std::cout << "No se pudo completar el arbol porque el grafo es no conexo" << std::endl;
  } else {
    cout << "El peso del arbol generador de minimo coste es " << pesoMST << std::endl;
  }
}

void GRAFO::PDM() //Construye un recorrido en amplitud desde un nodo inicial. Esto es lo que hicimos en una tabla en la clase de teoria (con las distancia y esas cosas)
{
  deque<unsigned> dcola;
  vector<int> d;
  vector<unsigned> pred;
  vector<bool> Encola;  // Visitado
  unsigned s;

  std::cout << "Escribe el nodo de inicio: ";
  std::cin >> s;

  if (s > n || s < 1) {
    std:cerr << "Se ha producido un error, el nodo de inicio se ha salido del rango del grafo." 
             << std::endl;
    return;
  }

  s = s - 1;

  Encola.resize(n, false);
  d.resize(n, maxint);
  pred.resize(n, UERROR);

  d[s] = 0;
  pred[s] = s;

  dcola.push_back(s);
  Encola[s] = true;

  while (!dcola.empty()) {
    
    unsigned k = dcola.front();
    dcola.pop_front();
    Encola[k] = false;   
    
    if ((d[k] < (static_cast<int>(n) - 1) * peso_minimo_) && (peso_minimo_ < 0)) {
      std::cout << "EL grafo contiene circuitos de coste negativos, por lo que no se pudo aplicar " 
                << "adecuadamente el algoritmo PDM." << std::endl;
      return;
    }

    for (int j{0}; j < LS[k].size(); j++) {
      if (d[LS[k][j].j] > d[k] + LS[k][j].c) {
        // si el nodo j nunca ha estado en la cola
        if (pred[LS[k][j].j] == UERROR) {
          dcola.push_back(LS[k][j].j);
        } else { // si ya ha estado en la cola
          if (!Encola[LS[k][j].j]) {  // si no esta en la cola
            dcola.push_front(LS[k][j].j);
          }
        }
        d[LS[k][j].j] = d[k] + LS[k][j].c;
        pred[LS[k][j].j] = k;
        Encola[LS[k][j].j] = true;
      }  
    } 

  }
  
  // Detectar circuito de coste negativo = apto+
  // Si no hay => Cualquier camino optimo es elemental => a lo sumo usara n-1 arcos
  // Cmin = min(Cij : cij <0)  Detectar el coste mas megativo de los arcos del grafo
  // detecto un circuito si la etiqueta distancia de un nodo di < (n-1)*Cmin     Asi sabemos si hay un circuito de coste negativo que se repitio 
  // muchas veces asi bajando el coste del circuito, esto porque el coste menor del PDM solo puede ser el coste mas pequeño de 
  // los arcos por n-1 arcos que tiene este PDM

  std::cout << "Soluciones:" << std::endl;

  // mostrar los caminos minimos
  for (unsigned i = 0; i < n; i++) {
    if (pred[i] != UERROR) {
      cout << "Distancia mínima de " << s + 1 << " a " << i + 1 << " es: " << d[i] << ". Camino: ";
      MostrarCamino(s, i, pred);
      cout << endl;
    }
  }

}

void GRAFO::MostrarCamino(unsigned s, unsigned i, vector<unsigned> pred)
{
  if (i != s)
   {
    MostrarCamino(s,pred[i],pred);
    cout << " -> " << i+1;
   }
  else
  cout << i+1;
}