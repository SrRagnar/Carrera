#include <iostream>
#include <vector>

struct Clasificacion {
  std::string nombre_del_equipo;
  int puntuacion;
};

struct EquipoFantasy {
  std::string nombre_equipo = "default";
  int partidos_jugados = 0;
  int partidos_ganados = 0;
  int partidos_empatados = 0;
  std::vector<Clasificacion> CrearTabla(const std::vector<EquipoFantasy>&  
                                        equipos_fantasy) {
    std::vector<Clasificacion> tabla;
    for (EquipoFantasy equipo : equipos_fantasy) {
      int puntuacion_total{partidos_ganados * 3 + partidos_empatados};
      Clasificacion equipo_n{equipo.nombre_equipo, puntuacion_total};
      tabla.emplace_back(equipo_n);
    }
    return tabla;
  }
};

int main() {
  // El structo se puedo poner o no, es meramente visual al declarar una 
  // variable.  
  struct EquipoFantasy prueba1{"Equipo1", 10, 5, 1};
  std::cout << prueba1.nombre_equipo << std::endl;
  std::vector<EquipoFantasy> equipos_fantasy;
  equipos_fantasy.reserve(22);
  equipos_fantasy.emplace_back(prueba1);
  return 0;
} 