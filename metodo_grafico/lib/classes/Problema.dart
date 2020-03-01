import 'package:math_expressions/math_expressions.dart';
import 'package:metodo_grafico/classes/Funcion.dart';

class Problema {
  Funcion _funcionObjetivo;
  num _numRestricciones;
  bool max;
  List<Funcion> restricciones; // Funciones originales de las restricciones

  Problema(Funcion fo, num res,List<Funcion> fr,bool op) {
    _funcionObjetivo = fo; 
    _numRestricciones = res;
    restricciones = fr;
    max=op;
    buscarIntersecciones();
    print("Ya llegue");
  }
  // Para cada restricción busara los pares ordenados según las soluciones
  // Guardar cada par ordenado en las listas 'x' 'y' de las funciones de restricción
  void buscarIntersecciones(){
    interseccionEjeX();
    for(int i =0;i<restricciones.length-1;i++){
      for(int j=i+1;j<restricciones.length;j++){
        double dividendo=restricciones[j].b.getConstantValue()-restricciones[i].b.getConstantValue();
        double divisor= restricciones[i].m.getConstantValue()-restricciones[j].m.getConstantValue();

        //Evaluamos interseccion en X
        Number aux= new Number(dividendo/divisor);

        //Evaluamos interseccion en Y
        ContextModel cm = new ContextModel();
        cm.bindVariable(restricciones[i].equis, aux);
        double s=restricciones[i].exp.evaluate(EvaluationType.REAL, cm);

        restricciones[i].x.add(aux.getConstantValue());
        restricciones[i].y.add(s);
        
        restricciones[j].x.add(aux.getConstantValue());
        restricciones[j].y.add(s);

        //Evaluamos interseccion x,y en Funcion Objetivo
        Number aux1=new Number(s);
        ContextModel cm1 = new ContextModel();
        cm1.bindVariable(_funcionObjetivo.equis, aux);
        cm1.bindVariable(_funcionObjetivo.ie, aux1);
        double s2=_funcionObjetivo.exp.evaluate(EvaluationType.REAL, cm1);
        restricciones[i].solucion.add(s2);
        restricciones[j].solucion.add(s2);

      }

    }
    interseccionEjeY();
  }
  void interseccionEjeX(){
    for(int i = 0; i<restricciones.length;i++){
      Number cero = new Number(0);
      ContextModel cm = new ContextModel();
      cm.bindVariable(restricciones[i].equis, cero);
      double s=restricciones[i].exp.evaluate(EvaluationType.REAL, cm);
      restricciones[i].x.add(0.0);
      restricciones[i].y.add(s);


      //Evaluamos interseccion x,y en Funcion Objetivo
      Number aux1=new Number(s);
      ContextModel cm1 = new ContextModel();
      cm1.bindVariable(_funcionObjetivo.equis, cero);
      cm1.bindVariable(_funcionObjetivo.ie, aux1);
      double s2=_funcionObjetivo.exp.evaluate(EvaluationType.REAL, cm1);
      restricciones[i].solucion.add(s2);
    }
  }
  void interseccionEjeY(){
    for(int i = 0; i<restricciones.length;i++){
      Number cero = new Number(0);
      ContextModel cm = new ContextModel();
      cm.bindVariable(restricciones[i].equis, cero);
      double s1=restricciones[i].inverso.evaluate(EvaluationType.REAL, cm);
      restricciones[i].y.add(0.0);
      restricciones[i].x.add(s1);

      //Evaluamos interseccion x,y en Funcion Objetivo
      Number aux1=new Number(s1);
      ContextModel cm1 = new ContextModel();
      cm1.bindVariable(_funcionObjetivo.equis, aux1);
      cm1.bindVariable(_funcionObjetivo.ie, cero);
      double s2=_funcionObjetivo.exp.evaluate(EvaluationType.REAL, cm1);
      restricciones[i].solucion.add(s2);
    }
  }
  
}