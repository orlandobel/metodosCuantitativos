import 'package:metodo_grafico/classes/Funcion.dart';

class Problema {
  Funcion _funcionObjetivo;
  num _numRestricciones;
  bool max;
  List<Funcion> _restricciones; // Funciones originales de las restricciones
  List<Funcion> _funcionRestricciones; // Funicones despejadas de las restricciones

  Problema(Funcion fo, num res,List<Funcion> fr,bool op) {
    _funcionObjetivo = fo;
    _numRestricciones = res;
    _restricciones = fr;
    max=op;
    print("Ya llegue");
  }

  // Para cada restricción busara los pares ordenados según las soluciones
  // Guardar cada par ordenado en las listas 'x' 'y' de las funciones de restricción
  void buscarCoordenadas() {

  }
  
}