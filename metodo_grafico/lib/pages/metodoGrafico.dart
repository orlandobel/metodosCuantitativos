import 'package:flutter/material.dart';

class metodoGrafico extends StatefulWidget
{
  @override
  _metodoGraficoState createState() => _metodoGraficoState();
}

class _metodoGraficoState extends State<metodoGrafico>
{
   int selectedRadio; 
    var data = ['1'];

   void _incrementCounter() {
    setState(() {
      var count = data.length + 1;
      data.add(count.toString());
    });
  }

  void _decrementCounter() {
    setState(() {
      data.removeLast();
    });
  }


   @override

    setSelectedRadio(int val){
    setState(() {
      selectedRadio = val;
    });
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar
      (
        elevation: 0.0,
       // backgroundColor: Colors.transparent,
        leading: IconButton
        (
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text('Titulo', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),

      ),
body: SingleChildScrollView(child: 
Column(
  mainAxisAlignment: MainAxisAlignment.start, 
    children: <Widget>[
      ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
        Text("Maximizar"),
        Radio(value: 0,groupValue: selectedRadio, activeColor: Colors.green,onChanged: (val){
          setSelectedRadio(val);
        },),
        Text("Minimizar "),
        Radio(value: 1, groupValue: selectedRadio, activeColor: Colors.blue,onChanged: (val){
          setSelectedRadio(val);
        },)
      ],
    ) ,
    Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListView.builder(
              itemCount: data.length,
              padding: EdgeInsets.all(20.0),
              shrinkWrap: true,
              itemBuilder: (context, int index) {
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topCenter,
                        child: 
                            Container(
                              alignment: Alignment.topCenter,
                              child:  TextField(
                               keyboardType: TextInputType.phone,
                             decoration: new InputDecoration(   border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), filled: true,),
                    ),
                            )  
                      )
                    ],
                  ),  
                );
              },
            ),
          ],
        ),
      ),
     
            
],
),
    ),
 floatingActionButton:Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FloatingActionButton(
              onPressed: _decrementCounter,
              heroTag: "dx",
              tooltip: 'Decrement',
              child: Icon(Icons.remove),
            ),
            FloatingActionButton(
              onPressed: _incrementCounter,
              heroTag: "xd",
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
            
          ],
        )

    );
  }
}

 