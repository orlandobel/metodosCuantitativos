import 'package:flutter/material.dart';

class metodoGrafico extends StatefulWidget {
  @override
  _metodoGraficoState createState() => _metodoGraficoState();
}

class _metodoGraficoState extends State < metodoGrafico > {
  int selectedRadio;
  var data = ['1'];
  final _formKey = GlobalKey < FormState > ();

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
  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
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
                  Radio(value: 0, groupValue: selectedRadio, activeColor: Colors.green, onChanged: (val) {
                    setSelectedRadio(val);
                  }, ),
                  Text("Minimizar "),
                  Radio(value: 1, groupValue: selectedRadio, activeColor: Colors.blue, onChanged: (val) {
                    setSelectedRadio(val);
                  }, )
                ],
              ),
            ),
            SliverList(

              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: < Widget > [
                        MyTextFormField(),
                        Text(" + ", style: TextStyle(
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
              child: SizedBox(height: 80,),
            )
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
              onPressed: _incrementCounter,
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