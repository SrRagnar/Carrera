template<class T>
void matrix_t<T>::Escalera() const {
  int rango{get_m()};
  for (int posicion{1}; posicion <= rango; ++posicion) {
    if (posicion == rango) {
      std::cout << at(posicion, posicion);
      break;
    }
    std::cout << at(posicion, posicion) << " " << at(posicion, posicion + 1) << " ";
  }
}

template<class T>
void matrix_t<T>::EscaleraBaja() const {
  int rango{get_m()};
  std::cout << at(1, 1) << " ";
  for (int posicion{2}; posicion <= rango; ++posicion) {
    std::cout << at(posicion, posicion - 1) << " " << at(posicion, posicion) << " ";
  }
}

template<class T>
void matrix_t<T>::DiagonalSecundaria() const{
  int rango{get_m()};
  for (int posicion{1}; posicion <= rango; ++posicion) {
    std::cout << at(posicion, rango - posicion + 1) << " ";
  }
}

template<class T>
void matrix_t<T>::TriangularInferior() const {
  int rango{get_m()};
  for (int fila{1}; fila <= rango; ++fila) {
    for (int columna{1}; columna <= fila; ++columna) {
      std::cout << at(fila, columna) << " ";
    }
    std::cout << std::endl;
  }
}

template<class T>
void matrix_t<T>::TriangularSuperior() const {
  int rango{get_m()};
  for (int fila{1}; fila <= rango; ++fila) {
    for (int espacios{0}; espacios <= fila -1; ++espacios) {
      std::cout << "  ";
    }
    for (int columna{fila}; columna <= rango; ++columna) {
      std::cout << at(fila, columna) << " ";
    }
    std::cout << std::endl;
  }
}

template<class T>
void matrix_t<T>::EscaleraSecundaria() const {
   int rango{get_m()};
  for (int posicion{1}; posicion <= rango; ++posicion) {
    if (posicion == rango) {
      std::cout << at(posicion, rango - posicion + 1);
      break;
    }
    std::cout << at(posicion, rango - posicion + 1) << " " << at(posicion, rango - posicion) << " ";
  }
}

template<class T>
void matrix_t<T>::EscaleraBajaSecundaria() const {
  int rango{get_m()};
  std::cout << at(1, rango) << " ";
  for (int posicion{2}; posicion <= rango; ++posicion) {
    std::cout << at(posicion, rango - posicion + 2) << " " << at(posicion, rango - posicion + 1) << " ";
  }
}