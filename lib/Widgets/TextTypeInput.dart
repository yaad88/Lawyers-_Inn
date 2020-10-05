import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextTypeInput extends StatelessWidget {
  String placeholder;
  Function validator;
  Function onSaved;
  IconData icon;
  TextInputType kbtype;
  bool isPassword;

  //String value;

  TextTypeInput(
      {this.placeholder, this.icon, this.onSaved, this.validator, this.kbtype, this.isPassword});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(50, 10, 50, 50),
      decoration: BoxDecoration(
        border: Border.all(
          //color: Colors.teal,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        padding: EdgeInsets.all(5),
        child: TextFormField(

          keyboardType: kbtype,
          decoration: InputDecoration(
            focusColor: Colors.teal,
            border: InputBorder.none,
            labelText: placeholder,
            icon: Icon(icon),
          ),
          validator: validator,
          onSaved: onSaved,
          obscureText: isPassword?true:false,

        ),
      ),
    );
  }
}