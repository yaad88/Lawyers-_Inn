

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_new_bloc/models/finalQuesion.dart';
import 'package:new_new_bloc/Widgets/RadioModel.dart';

class MultipleChoiceListBuilder extends StatefulWidget {
  List<RadioModel> sampleData;
  String title;
  finalQuestion question;

  MultipleChoiceListBuilder({this.sampleData, this.title, this.question});

  @override
  _MultipleChoiceListBuilderState createState() => _MultipleChoiceListBuilderState();
}



class _MultipleChoiceListBuilderState extends State<MultipleChoiceListBuilder> {
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
              splashColor: Colors.blueAccent,


              onTap: () {
                setState(() {
                  widget.sampleData
                      .forEach((element) => element.isSelected = false);
                  widget.sampleData[index].isSelected = true;
                  widget.question.answer=(widget.sampleData[index].text) ;
                });
              },
              child: new RadioItem(widget.sampleData[index],false),
            );

          },
      ),
        ),
        SizedBox(height: 50,),
    ],
    );
  }
}

