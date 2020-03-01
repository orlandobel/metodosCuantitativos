import 'package:flutter/material.dart';
import 'package:metodo_grafico/pages/main_page.dart';

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp
    (
      title: 'Dashboard',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}