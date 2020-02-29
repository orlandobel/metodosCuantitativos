import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metodo_grafico/classes/Funcion.dart';
import 'package:metodo_grafico/classes/Problema.dart';

class metodoGrafico extends StatefulWidget {
  @override
  _metodoGraficoState createState() => _metodoGraficoState();
}

class _metodoGraficoState extends State < metodoGrafico > {
  int selectedRadio= 0;
  var data = ['1','2'];
  var maxmin = " ≤ ";
  bool maxi;
  List<List<TextEditingController>> controladores = [[TextEditingController(),TextEditingController(),TextEditingController()]];
  List<MyTextFormField> formObjetivos=List<MyTextFormField>();/* =[new MyTextFormField(controladores[0][1]),new MyTextFormField(), new MyTextFormField()];*/
  List<Widget> objetivo=List<Widget>();
  List<List<MyTextFormField>> restricciones=List<List<MyTextFormField>>();
  List<List<Widget>> wRestricciones=List<List<Widget>>();
  
  static final _formKey = GlobalKey < FormState > ();


  void _incrementCounter() {
    setState(() {
      controladores.add([
    TextEditingController(),TextEditingController(),TextEditingController()
  ]);
      data.add((data.length+1).toString());
      restricciones.add(
        [new MyTextFormField(controladores[controladores.length-1][0]),
      new MyTextFormField(controladores[controladores.length-1][1]),
      new MyTextFormField(controladores[controladores.length-1][2])]);
      wRestricciones.add([
        restricciones[restricciones.length-1][0].build(context),Text(" + ", style: TextStyle( fontSize: 18),),
        restricciones[restricciones.length-1][1].build(context),Text(maxmin, style: TextStyle(fontSize: 18), ),
        restricciones[restricciones.length-1][2].build(context)
    ]);
    });
  }

  void _decrementCounter() {
    setState(() {
      if(data.length > 2  )
         data.removeLast();
         controladores.removeLast();
         restricciones.removeLast();
         wRestricciones.removeLast();
    });
  }

  @override
  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
      if ( val == 0){
        maxmin = " ≤ ";
        maxi=true;
      }else{
        maxmin = " ≥ ";
        maxi=false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
  formObjetivos.add(MyTextFormField(controladores[0][0]));
  formObjetivos.add(MyTextFormField(controladores[0][1]));
  formObjetivos.add(MyTextFormField(controladores[0][2]));
  
  objetivo=[formObjetivos[0].build(context),Text(" X1 + ", style: TextStyle(fontSize: 18), ),
  
  formObjetivos[1].build(context),Text("X2 = ", style: TextStyle(fontSize: 18),),
  formObjetivos[2].build(context)];
  //formObjetivos =[new MyTextFormField(controladores[0][0]),new MyTextFormField(controladores[0][1]), new MyTextFormField(controladores[0][2])];
  controladores.add([
    TextEditingController(),TextEditingController(),TextEditingController()
  ]);
  controladores.add([
    TextEditingController(),TextEditingController(),TextEditingController()
  ]);

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
  

  wRestricciones= [[
    restricciones[0][0].build(context),Text(" + ", style: TextStyle( fontSize: 18),),
    restricciones[0][1].build(context),Text(maxmin, style: TextStyle(fontSize: 18), ),
    restricciones[0][2].build(context)
    ],[
    restricciones[1][0].build(context),Text(" + ", style: TextStyle( fontSize: 18),),
    restricciones[1][1].build(context),Text(maxmin, style: TextStyle(fontSize: 18), ),
    restricciones[1][2].build(context)
    ]];
  
    return Scaffold(
      body: Form(
        key: _formKey,
        child: CustomScrollView(

          slivers: < Widget > [
            SliverAppBar(
              elevation: 0.0,
              // backgroundColor: Colors.transparent,
              leading: IconButton(
                color: Colors.black,
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.arrow_back, color: Colors.black),
              ),
              title: Text('Titulo', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
            ),
            SliverToBoxAdapter(
              child: ButtonBar(
                alignment: MainAxisAlignment.center,
                children: < Widget > [
                  Text("Maximizar"),
                  Radio(value: 0, groupValue: selectedRadio, activeColor: Colors.blue, onChanged: (val) {
                    setSelectedRadio(val);
                  }, ),
                  Text("Minimizar "),
                  Radio(value: 1, groupValue: selectedRadio, activeColor: Colors.blue, onChanged: (val) {
                    setSelectedRadio(val);
                  }, )
                ],
              ),
            ),

            SliverToBoxAdapter(
              child: Text(" Función objetivo ", style: TextStyle(
                          fontSize: 18
                        ),textAlign: TextAlign.center, ),
            ),
            
            SliverToBoxAdapter(
              child: Container(

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: formObjetivos,
                      
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
              print("entre");
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
              onPressed: _decrementCounter,
              heroTag: "dx",
              tooltip: 'Decrement',
              child: Icon(Icons.remove),
            ),
            Builder(
              
              builder: (context)=>FloatingActionButton(
              onPressed: (){
                if (data.length < 6){
                  _incrementCounter();
                }
                else{
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Solo puedes agregar 6 restricciones'))
                  );
                }
              },
              heroTag: "xd",
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
              
            ),
          ],
        ), 
      )
    );
  }

  void submit(){
    var funObj = formObjetivos[0].valor+"x + "+formObjetivos[1].valor+"y = "+formObjetivos[2].valor;//Funcion objetivo
    Funcion funcion=new Funcion(funObj);
    var numRestri=data.length;//Numero de restricciones
    
    if(selectedRadio==0)
      maxi = true;//Operacion de maximizar
    else  
      maxi = false; //Operacion de minimizar
    
    List<Funcion> fun;

    for(int i=0;i<data.length;i++){
      var aux=restricciones[0][i].valor;
      fun[i]=new Funcion(aux);
    }
    print(funObj);
    print(numRestri);
    print(fun.toString());
    print(maxi);

    Problema prob = new Problema(funcion, numRestri,fun,maxi);
   
    //restricciones[0][0]
    //primer corchete -> numero de restricciones
    // segundo corchete- > 0->x1,1->x2,2->igual
    //var aux =ouno.toString()+"x"+odos.toString()+"y"+"="+oigual.toString();
    //List<num> restricciones;

  }
}

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  String valor;

  MyTextFormField(this.controller, {
    this.hintText
  });


  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: TextFormField(
         controller: controller,
         onChanged: (num){
           this.valor = num;
         },
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: EdgeInsets.all(15.0),
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.grey[200],
          ),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
      WhitelistingTextInputFormatter.digitsOnly],
        ),
      )
    );
  }

  

}
