import 'package:math_expressions/math_expressions.dart';

class Funcion {
  List<num> x,y,solucion;
  Number m,b;
  Variable vX,vY;
  Expression expOriginal,expInverso,expDespejada;
  double limite;

  Funcion(List<double> funcion, bool fo) {
    x=new List<num>();
    y=new List<num>();
    solucion=new List<num>();
    vX = new Variable('x');
    vY=new Variable('y');
    m=new Number(-funcion[0]/funcion[1]);
    Number aux1=new Number(funcion[0]);
    Number aux2=new Number(funcion[1]);
    expOriginal=(aux1*vX)+(aux2*vY);
    limite=0;
    if(fo) b = new Number(0);
    else {
      b = new Number(funcion[2] / funcion[1]);
      limite = funcion[2];
    }
    expInverso=(vX-b)/m;
    expDespejada=m*vX+b;
    }

  }


