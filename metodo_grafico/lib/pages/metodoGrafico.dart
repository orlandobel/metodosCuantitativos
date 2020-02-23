import 'package:flutter/material.dart';
import 'main_page.dart';
class metodoGrafico extends StatefulWidget {
  @override
  _metodoGraficoState createState() => _metodoGraficoState();
}

class _metodoGraficoState extends State < metodoGrafico > {
  int selectedRadio= 0;
  var data = ['1'];
  var maxmin = " ≤ ";
  final _formKey = GlobalKey < FormState > ();

  void _incrementCounter(BuildContext context) {
    setState(() {
      var count = data.length + 1;
      if (data.length < 6){
        data.add(count.toString());
      }    
      else{
          Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text ('Solo puedes ingresar 6 restricciones')
          )
        );
      }

    });
  }

  void _decrementCounter() {
    setState(() {
      if(data.length > 1  )
         data.removeLast();
    });
  }


  @override
  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
      if ( val == 0)
        maxmin = " ≤ ";
      else
        maxmin = " ≥ ";
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
                      children: < Widget > [
                        MyTextFormField(),
                        Text(" + ", style: TextStyle(
                          fontSize: 18
                        ), ),
                        MyTextFormField(),
                        Text(" = ", style: TextStyle(
                          fontSize: 18
                        ), ),
                        MyTextFormField(),
                      ],
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
                      children: < Widget > [
                        MyTextFormField(
                          hintText: "x1",
                        ),
                        Text(" + ", style: TextStyle(
                          fontSize: 18
                        ), ),
                        MyTextFormField(hintText: "x2",),
                        Text(maxmin, style: TextStyle(
                          fontSize: 18
                        ), ),
                        MyTextFormField(),
                      ],
                    ),
                  );

                },
                childCount: data.length,
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
               Navigator.of(context).push(MaterialPageRoute(builder: (_) => MainPage()));
            },
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            
            child: Text("Ingresar",
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
            FloatingActionButton(
              onPressed: (){
                _incrementCounter(context);
              },
              heroTag: "xd",
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
          ],
        ), 
      )
    );
  }


}

class MyTextFormField extends StatelessWidget {
  final String hintText;


  MyTextFormField({
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: TextFormField(
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: EdgeInsets.all(15.0),
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.grey[200],
          ),

          keyboardType: TextInputType.number
        ),
      )
    );
  }
}