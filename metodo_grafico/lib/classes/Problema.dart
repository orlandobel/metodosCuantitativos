import 'package:metodo_grafico/classes/Funcion.dart';

class Problema {
  Funcion _funcionObjetivo;
  num _numRestricciones;
  bool max;
  List<Funcion> _restricciones; // Funciones originales de las restricciones
  List<Funcion> _funcionRestricciones; // Funicones despejadas de las restricciones
  List<List<num>> _coordenadas; // Soluciones en coordenadas de las restricciones

  Problema(Funcion fo, num res,List<Funcion> fr,bool op) {
    _funcionObjetivo = fo;
    _numRestricciones = res;
    _restricciones = fr;
    max=op;
  }

  // Se iterará para despejar las restricciones
  void calcularRestricciones() {

  }

  // Para cada restricción busara los pares ordenados según las soluciones
  void buscarCoordenadas() {

  }

  get coordenadas => _coordenadas;
  
}