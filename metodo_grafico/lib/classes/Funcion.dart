import 'dart:ffi';
import 'dart:math' as math;
import 'package:math_expressions/math_expressions.dart';

class Funcion {
  List<num> x;
  List<num> y;
  List<num> solucion;
  Expression exp;

  Funcion(List<double> funcion, bool fo) {
    if(fo){
    Variable x = new Variable('x') /*y = new Variable('y')*/;
    Number a = new Number(funcion[0]);
    Number b = new Number(funcion[1]);
     exp=(-a/b)*x;
    
    }else{
    Variable x = new Variable('x') /*y = new Variable('y')*/;
    Number a = new Number(funcion[0]);
    Number b = new Number(funcion[1]);
    Number c = new Number(funcion[2]);
     exp=(c-(a*x))/b;
    }
    
  }

}