import 'package:flutter/material.dart';

class metodoGrafico extends StatefulWidget
{
  @override
  _metodoGraficoState createState() => _metodoGraficoState();
}

class _metodoGraficoState extends State<metodoGrafico>
{
  int selectedRadio;
  int selectedRadioTile;
   @override
   void initState() {
    // TODO: implement initState
    super.initState();
    selectedRadio = 0;
    selectedRadioTile=0;
  }



   setSelectedRadioTile(int val){
    setState(() {
      selectedRadioTile = val;
    });
 }
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
body: Column(
  mainAxisAlignment: MainAxisAlignment.start,
  children: <Widget>[
   /* RadioListTile(value: 1, groupValue: selectedRadioTile, title: Text("Maximizar"), subtitle: Text("Radio"),
    onChanged: (val){
setSelectedRadioTile(val);
    },
    selected: false,
    ),
      RadioListTile(value: 2, groupValue: selectedRadioTile, title: Text("Minimizar"), subtitle: Text("Radio"),
    onChanged: (val){
setSelectedRadioTile(val);
    },
    selected: false,
    ),*/
    
    ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Maximizar"),
        Radio(value: 0, groupValue: selectedRadio, activeColor: Colors.green,onChanged: (val){
          setSelectedRadio(val);
        },),
        Text("Minimizar "),
        Radio(value: 1, groupValue: selectedRadio, activeColor: Colors.blue,onChanged: (val){
          setSelectedRadio(val);
        },)
      ],
    ) 
  ],
),
    );
  }
}

 