import 'package:flutter/material.dart';

class metodoGrafico extends StatefulWidget
{
  @override
  _metodoGraficoState createState() => _metodoGraficoState();
}

class _metodoGraficoState extends State<metodoGrafico>{
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
  Widget build(BuildContext context) {
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.0;
     final _formKey = GlobalKey<FormState>();
    return Scaffold(
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
      body: Form(
      key: _formKey,
      child: Column(
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
          Expanded(child: CustomScrollView(

        slivers: <Widget>[
          ///First sliver is the App Bar
          
          SliverList(
            
            delegate: SliverChildBuilderDelegate(
              
              (BuildContext context, int index) {
               
                return  Container(
            alignment: Alignment.topCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.topCenter,
                  width: halfMediaWidth,
                  child: MyTextFormField(
                    
                    
                  ),
                ),
                Text(" + "),
                Container(
                  alignment: Alignment.topCenter,
                  width: halfMediaWidth,
                  child: MyTextFormField(
                    
                    
                    
                  ),
                )
              ],
            ),
          );
               
              },
              childCount: data.length,
            ),
          )
        ],
      ),),
          
          
        

         
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

class MyTextFormField extends StatelessWidget {
  final String hintText;
 

  MyTextFormField({
    this.hintText,

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}