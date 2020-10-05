import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_new_bloc/models/finalQuesion.dart';
import 'package:new_new_bloc/Widgets/RadioModel.dart';

class DropDownInput extends StatefulWidget {
  String placeholder;

  //Function onChanged;
  List<RadioModel> options;
  String selectedOption;
  finalQuestion question;

  //String selectedanswer;

  DropDownInput(
      {this.placeholder, this.options, this.selectedOption, this.question});

  @override
  _DropDownInputState createState() => _DropDownInputState();
}

class _DropDownInputState extends State<DropDownInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Text(
              widget.placeholder
          ),
        ),
        Form(
          child: DropdownButton(
            hint: widget.selectedOption == null
                ? Text('Please choose an option', style: TextStyle(
                color: Colors.red
            ),)
                : Text(widget.selectedOption),
            value: widget.selectedOption,

            onChanged: (String val) {
              setState(() {
                widget.selectedOption = val;
                //widget.question.answer.add(widget.selectedOption);
                widget.question.answer = widget.selectedOption;
              });
            },


            items: widget.options.map((RadioModel index) {
              return DropdownMenuItem<String>(
                value: index.text,
                child: Text(index.text),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 50,)
      ],
    );
  }
}