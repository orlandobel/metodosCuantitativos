import 'package:math_expressions/math_expressions.dart';
import 'package:metodo_grafico/classes/Funcion.dart';
/*
***** author Hector
  */
class Problema {
  Funcion _funcionObjetivo;
  num _numRestricciones;
  bool max;
  List<Funcion> _restricciones; // Funciones originales de las restricciones
  //List<Funcion> _funcionRestricciones; // Funicones despejadas de las restricciones

  Problema(Funcion fo, num res,List<Funcion> fr,bool op) {
    _funcionObjetivo = fo; 
    _numRestricciones = res;
    _restricciones = fr;
    max=op;
    buscarIntersecciones();
    print("Ya llegue");
  }
  // Para cada restricción busara los pares ordenados según las soluciones
  // Guardar cada par ordenado en las listas 'x' 'y' de las funciones de restricción
  void buscarIntersecciones(){
    for(int i =0;i<_restricciones.length-1;i++){
      for(int j=i+1;j<_restricciones.length;j++){
        double dividendo=_restricciones[j].b.getConstantValue()-_restricciones[i].b.getConstantValue();
        double divisor= _restricciones[i].m.getConstantValue()-_restricciones[j].m.getConstantValue();
        
        Number aux= new Number(dividendo/divisor);

        ContextModel cm = new ContextModel();
        cm.bindVariable(_restricciones[i].equis, aux);

        double s=_restricciones[i].exp.evaluate(EvaluationType.REAL, cm);

        _restricciones[i].x.add(aux.getConstantValue());
        _restricciones[i].y.add(s);
        
        _restricciones[j].x.add(aux.getConstantValue());
        _restricciones[j].y.add(s);
      }
      //Pantalla_de_espera_mientras_voy_a_mear.destroy;
      }
  }
  
}