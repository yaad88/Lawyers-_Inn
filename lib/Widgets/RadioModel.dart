import 'package:flutter/material.dart';
//import 'package:show_survey_questions/finalQuesion.dart';

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  final bool isCheckBox;
  RadioItem(this._item, this.isCheckBox);
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.only(bottom: 10),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Container(
            margin: EdgeInsets.fromLTRB(50,0,10,0),
            height: 50.0,
            width: 50.0,
            child: new Center(
              child: new Text('',
                  style: new TextStyle(
                      color: _item.isSelected ? Colors.white : Colors.black,
                      //fontWeight: FontWeight.bold,
                      fontSize: 18.0)),
            ),
            decoration: new BoxDecoration(
              color: _item.isSelected ? Colors.teal : Colors.transparent,
              border: new Border.all(
                  width: 1.0,
                  color: _item.isSelected ? Colors.teal : Colors.grey),
              borderRadius: isCheckBox?BorderRadius.circular(50) :const BorderRadius.all(const Radius.circular(10.0)),
              //borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
            ),
          ),
          new Container(
            margin: new EdgeInsets.only(left: 10.0),
            child: new Text(_item.text),
          )
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  //final String buttonText;
  final String text;

  RadioModel({this.isSelected,  this.text});
}