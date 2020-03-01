import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
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
           print(num);
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