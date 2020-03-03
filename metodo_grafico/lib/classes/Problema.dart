import 'package:flutter/rendering.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:metodo_grafico/classes/Funcion.dart';

class Problema {
  Funcion _funcionObjetivo;
  num _numRestricciones;
  bool max;
  List<Funcion> restricciones; // Funciones originales de las restricciones
  List<double> solucionFinal;

  Problema(Funcion fo, num res,List<Funcion> fr,bool op) {
    _funcionObjetivo = fo; 
    _numRestricciones = res;
    restricciones = fr;
    max=op;
    solucionFinal = new List<double>();

    buscarIntersecciones();
    calcularSolucion();
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
        cm.bindVariable(restricciones[i].vX, aux);
        double s=restricciones[i].expDespejada.evaluate(EvaluationType.REAL, cm);

        restricciones[i].x.add(aux.getConstantValue());
        restricciones[i].y.add(s);
        
        restricciones[j].x.add(aux.getConstantValue());
        restricciones[j].y.add(s);

        //Evaluamos interseccion x,y en Funcion Objetivo
        Number aux1=new Number(s);
        ContextModel cm1 = new ContextModel();
        cm1.bindVariable(_funcionObjetivo.vX, aux);
        cm1.bindVariable(_funcionObjetivo.vY, aux1);
        double s2=_funcionObjetivo.expOriginal.evaluate(EvaluationType.REAL, cm1);
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
      cm.bindVariable(restricciones[i].vX, cero);
      double s=restricciones[i].expDespejada.evaluate(EvaluationType.REAL, cm);
      restricciones[i].x.add(0.0);
      restricciones[i].y.add(s);


      //Evaluamos interseccion x,y en Funcion Objetivo
      Number aux1=new Number(s);
      ContextModel cm1 = new ContextModel();
      cm1.bindVariable(_funcionObjetivo.vX, cero);
      cm1.bindVariable(_funcionObjetivo.vY, aux1);
      double s2=_funcionObjetivo.expDespejada.evaluate(EvaluationType.REAL, cm1);
      restricciones[i].solucion.add(s2);
    }
  }
  void interseccionEjeY(){
    for(int i = 0; i<restricciones.length;i++){
      Number cero = new Number(0);
      ContextModel cm = new ContextModel();
      cm.bindVariable(restricciones[i].vX, cero);
      double s1=restricciones[i].expInverso.evaluate(EvaluationType.REAL, cm);
      restricciones[i].y.add(0.0);
      restricciones[i].x.add(s1);

      //Evaluamos interseccion x,y en Funcion Objetivo
      Number aux1=new Number(s1);
      ContextModel cm1 = new ContextModel();
      cm1.bindVariable(_funcionObjetivo.vX, aux1);
      cm1.bindVariable(_funcionObjetivo.vY, cero);
      double s2=_funcionObjetivo.expOriginal.evaluate(EvaluationType.REAL, cm1);
      restricciones[i].solucion.add(s2);
    }
  }

  void calcularSolucion(){
    if (max) maximizar();
    else minimizar();
  
  }
  void maximizar(){
    solucionFinal.add(0);
    solucionFinal.add(0);
    solucionFinal.add(0);
    for (var i in restricciones){
      for(int j= 0; j<i.x.length; j++){
        int count = 0;
        for(var x in restricciones){
          ContextModel operacion = new ContextModel();
          operacion.bindVariable(x.vX,new Number(i.x[j]));
          operacion.bindVariable(x.vY,new Number(i.y[j]));
          double aux = x.expOriginal.evaluate(EvaluationType.REAL, operacion);
          if (aux <= x.limite) {
            count++;
          }
        }
        if(count == _numRestricciones){
          if (i.solucion[j]> solucionFinal[2]){
            solucionFinal[0] = i.x[j];
            solucionFinal[1] = i.y[j];
            solucionFinal[2] = i.solucion[j];
          }
        }
      }
    }
  }
  void minimizar(){
    solucionFinal.add(0);
    solucionFinal.add(0);
    solucionFinal.add(10000); // jeje que cosas no?
    for (var i in restricciones){
      for(int j= 0; j<i.x.length; j++){
        int count = 0;
        for(var x in restricciones){
          ContextModel operacion = new ContextModel();
          operacion.bindVariable(x.vX,new Number(i.x[j]));
          operacion.bindVariable(x.vY,new Number(i.y[j]));
          double aux = x.expOriginal.evaluate(EvaluationType.REAL, operacion);
          if (aux >= x.limite) {
            count++;
          }
        }
        if(count == _numRestricciones){
          if (i.solucion[j]< solucionFinal[2]){
            solucionFinal[0] = i.x[j];
            solucionFinal[1] = i.y[j];
            solucionFinal[2] = i.solucion[j];
          }
        }
      }
    }

  }
}