import 'package:math_expressions/math_expressions.dart';

class Funcion {
  List<num> x;
  List<num> y;
  List<num> solucion;
  Number m,b;
  Expression exp;
  Variable equis;
  Funcion(List<double> funcion, bool fo) {
    x=new List<num>();
    y=new List<num>();
    equis = new Variable('x');
    m= new Number(-funcion[0]/funcion[1]);
    if(fo){
      b = new Number(0);
    }else{
      b= new Number(funcion[2]/funcion[1]);
    }
    exp=m*equis+b;

    //exp=(c-(a*x))/b;
    
    //exp.evaluate(EvaluationType.REAL, context);
    

    
  }

}