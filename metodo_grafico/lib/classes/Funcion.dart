import 'package:math_expressions/math_expressions.dart';

class Funcion {
  List<num> x,y,solucion;
  Number m,b;
  Expression exp,inverso;
  Variable equis,ie;
 
  Funcion(List<double> funcion, bool fo) {
    x=new List<num>();
    y=new List<num>();
    solucion=new List<num>();
    equis = new Variable('x');
    m=new Number(-funcion[0]/funcion[1]);
    if(fo){
      b = new Number(0);
      Number aux1=new Number(funcion[0]);
      Number aux2=new Number(funcion[1]);
      ie=new Variable('y');
      exp=(aux1*equis)+(aux2*ie);
    }else{
      b= new Number(funcion[2]/funcion[1]);
      exp=m*equis+b;
      inverso=(equis-b)/m;
    }
  
  }

}