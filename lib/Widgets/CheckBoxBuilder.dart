

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_new_bloc/models/finalQuesion.dart';
import 'package:new_new_bloc/Widgets/RadioModel.dart';

class CheckBoxListBuilder extends StatefulWidget {
  List<RadioModel> sampleData;
  String title;
  finalQuestion question;

  List<String> answerlist = new List<String>();

  CheckBoxListBuilder({this.sampleData, this.title, this.question});

  @override
  _CheckBoxListBuilderState createState() => _CheckBoxListBuilderState();
}

class _CheckBoxListBuilderState extends State<CheckBoxListBuilder> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        Text(widget.title),
        SizedBox(height: 10,),
        Form(
          child: new ListView.builder(
            shrinkWrap: true,
            itemCount: widget.sampleData.length,
            itemBuilder: (BuildContext context, int index) {
              return new InkWell(
                //highlightColor: Colors.red,
                splashColor: Colors.teal,


                onTap: () {
                  setState(() {
                    //widget.sampleData.forEach((element) => element.isSelected = false);
                    if(widget.answerlist.contains(widget.sampleData[index].text)){
                      widget.sampleData[index].isSelected = false;
                      widget.answerlist.remove(widget.sampleData[index].text);
                    }
                    else{
                      widget.sampleData[index].isSelected = true;
                      widget.answerlist.add(widget.sampleData[index].text);
                    }

                    widget.question.answer = widget.sampleData[index].text;
                  });
                },
                child: new RadioItem(widget.sampleData[index],true),
              );

            },
          ),
        ),
        SizedBox(height: 50,),
      ],
    );
  }
}

