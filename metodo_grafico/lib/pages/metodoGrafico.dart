import 'package:flutter/material.dart';

class metodoGrafico extends StatefulWidget
{
  @override
  _metodoGraficoState createState() => _metodoGraficoState();
}

class _metodoGraficoState extends State<metodoGrafico>
{
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

    );
  }
}

