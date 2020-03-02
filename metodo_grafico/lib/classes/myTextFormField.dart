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
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            filled: true,
            
                 focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(450, 107, 23, 64))),
           fillColor: Colors.white,
          ),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            LengthLimitingTextInputFormatter(4),
            BlacklistingTextInputFormatter(RegExp('[ -,-]')),
          ],
        ),
      )
    );
  }
}