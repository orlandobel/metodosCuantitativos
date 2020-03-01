import 'package:flutter/material.dart';
import 'package:metodo_grafico/classes/Funcion.dart';
import 'package:metodo_grafico/classes/Problema.dart';
//import 'package:metodo_grafico/classes/Funcion.dart';
import 'package:metodo_grafico/classes/myTextFormField.dart';
//import 'package:metodo_grafico/classes/Problema.dart';

class metodoGrafico extends StatefulWidget {
  @override
  _metodoGraficoState createState() => _metodoGraficoState();
}

class _metodoGraficoState extends State < metodoGrafico > {

  int selectedRadio= 0;
  var data = ['1','2'];
  var maxmin = " ≤ ";
  bool maxi=true;
  bool aviseLimSuperior = false;
  List<List<TextEditingController>> controladores = List<List<TextEditingController>>();
  List<MyTextFormField> funObjetivo =List<MyTextFormField>();
  List<List<MyTextFormField>> restricciones=List<List<MyTextFormField>>();
  List<Widget> wObjetivo=List<Widget>();
  List<List<Widget>> wRestricciones=List<List<Widget>>();
  
  static final _formKey = GlobalKey < FormState > ();
  _metodoGraficoState(){
    controladores =
    [
      [TextEditingController(),TextEditingController()],
      [TextEditingController(),TextEditingController(),TextEditingController()],
      [TextEditingController(),TextEditingController(),TextEditingController()]
    ];
    funObjetivo= 
    [
      MyTextFormField(controladores[0][0]),MyTextFormField(controladores[0][1])
    ];
    wObjetivo=[
      funObjetivo[0].build(context),Text(" X1 + ", style: TextStyle(fontSize: 18), ),
      funObjetivo[1].build(context),Text("X2 ", style: TextStyle(fontSize: 18),)
    ];
  restricciones= [
      [
        MyTextFormField(controladores[1][0]),
        MyTextFormField(controladores[1][1]),
        MyTextFormField(controladores[1][2])
      ],
      [
        MyTextFormField(controladores[2][0]),
        MyTextFormField(controladores[2][1]),
        MyTextFormField(controladores[2][2])
      ]
    ];
  

  wRestricciones= [
    [
      restricciones[0][0].build(context),Text(" + ", style: TextStyle( fontSize: 18),),
      restricciones[0][1].build(context),Text(maxmin, style: TextStyle(fontSize: 18), ),
      restricciones[0][2].build(context)
    ],
    [
      restricciones[1][0].build(context),Text(" + ", style: TextStyle( fontSize: 18),),
      restricciones[1][1].build(context),Text(maxmin, style: TextStyle(fontSize: 18), ),
      restricciones[1][2].build(context)
    ]
    ];

    }

  void _incrementCounter() {
    setState(() {
      controladores.add([
        TextEditingController(),TextEditingController(),TextEditingController()
      ]);
      data.add((data.length+1).toString());
      restricciones.add(
        [
          new MyTextFormField(controladores[controladores.length-1][0]),
          new MyTextFormField(controladores[controladores.length-1][1]),
          new MyTextFormField(controladores[controladores.length-1][2])
        ]
      );
      wRestricciones.add(
        [
          restricciones[restricciones.length-1][0].build(context),Text(" + ", style: TextStyle( fontSize: 18),),
          restricciones[restricciones.length-1][1].build(context),Text(maxmin, style: TextStyle(fontSize: 18), ),
          restricciones[restricciones.length-1][2].build(context)
        ]);
    });
  }

  void _decrementCounter() {
    setState(() {
        data.removeLast();
        controladores.removeLast();
        restricciones.removeLast();
        wRestricciones.removeLast();
    });
  }

  @override
  setSelectedRadio(int i) {
    selectedRadio=i;
    print (i);
    if ( i == 0) {
      maxmin = " ≤ ";
      maxi = true;
    }
    else {
      maxmin = " ≥ ";
      maxi = false;
    }
    setState(() {
      wRestricciones.clear();
      for(int i=0; i<restricciones.length;i++){
        wRestricciones.add([
          restricciones[i][0].build(context),Text(" + ", style: TextStyle( fontSize: 18),),
          restricciones[i][1].build(context),Text(maxmin, style: TextStyle(fontSize: 18), ),
          restricciones[i][2].build(context)
        ]);
      }

    });

  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: CustomScrollView(

          slivers: < Widget > [
            SliverAppBar(
              elevation: 0.0,
              // backgroundColor: Colors.transparent,
              leading: IconButton(
                color: Colors.white,
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.arrow_back, color: Colors.white),
              ),
              title: Text('Método Grafico', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
            ),
            SliverToBoxAdapter(
              child: ButtonBar(
                alignment: MainAxisAlignment.center,
                children: < Widget > [
                  Text("Maximizar"),
                  Radio(value: 0, groupValue: selectedRadio, activeColor: Colors.blue, onChanged: (int) {
                    setSelectedRadio(int);
                  }, ),
                  Text("Minimizar "),
                  Radio(value: 1, groupValue: selectedRadio, activeColor: Colors.blue, onChanged: (int) {
                    setSelectedRadio(int);
                  }, )
                ],
              ),
            ),

            SliverToBoxAdapter(
              child: Text(" Función Objetivo ", style: TextStyle(
                          fontSize: 18
                        ),textAlign: TextAlign.center, ),
            ),
            
            SliverToBoxAdapter(
              child: Container(

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: wObjetivo,
                      
                    ),
                  ),
            ),

            SliverToBoxAdapter(
              child: Text(" Restricciones ", style: TextStyle(
                          fontSize: 18
                        ),textAlign: TextAlign.center, ),
            ),

            SliverList(
              
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: wRestricciones[index],
                    ),
                  );

                },
                childCount: wRestricciones.length,
              ),
              
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: 10,),
            ),

            SliverToBoxAdapter(
              child:  Padding(
                padding: const EdgeInsets.only(
                left: 50.0, right: 50.0, top: 10.0),
                child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.blue,
          child: MaterialButton(
            onPressed: () {
              submit();
             //  Navigator.of(context).push(MaterialPageRoute(builder: (_) => MainPage()));
            },
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            
            child: Text("Solucion",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
                ),
          ),
        ),
                  ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: 80,),
            ),

          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          left: 32
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: < Widget > [
            FloatingActionButton(
              heroTag: "menos",
              tooltip: 'Decrement',
              child: Icon(Icons.remove),
              onPressed: (){
                if (data.length > 2){
                  _decrementCounter();
                  aviseLimSuperior=false;
                }
              },

            ),
            Builder(
              builder: (context)=>FloatingActionButton(
                heroTag: "mas",
                tooltip: 'Increment',
                child: Icon(Icons.add),
              onPressed: (){
                if (data.length < 6){
                  _incrementCounter();
                }
                else{
                  if (!aviseLimSuperior){
                    Scaffold.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Solo puedes agregar 6 restricciones'))
                    );
                    aviseLimSuperior = true;
                  }

                }
              },

            ),
              
            ),
          ],
        ), 
      )
    );
  }

  void submit(){
    List<double> funObj=new List<double>();
    funObj.add(double.parse(funObjetivo[0].controller.text));
    funObj.add(double.parse(funObjetivo[1].controller.text));
    
    /*String funObj = funObjetivo[0].controller.text+"*x + "+
        funObjetivo[1].controller.text+"*y";*/
    Funcion funcion=new Funcion(funObj, true);
   
    List<Funcion> restriccionesFinales = new List<Funcion>();
    for (var i in restricciones){
        funObj.clear();
        funObj.add(double.parse(i[0].controller.text));
        funObj.add(double.parse(i[1].controller.text));
        funObj.add(double.parse(i[2].controller.text));
        /*String r = i[0].controller.text+"*x + "+i[1].controller.text+"*y - "+i[2].controller.text;
        print(r);*/
        restriccionesFinales.add(Funcion(funObj,false));
    }
    Problema problema = new Problema(funcion,data.length,restriccionesFinales,maxi);
    print('Termine');

  }
}

