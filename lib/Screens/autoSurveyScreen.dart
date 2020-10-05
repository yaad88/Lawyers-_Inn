import 'dart:convert';


import 'package:new_new_bloc/Apis/survey_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_new_bloc/Widgets/allWidgets.dart';

import 'package:new_new_bloc/models//Question.dart';
import 'package:http/http.dart' as http;

import 'package:new_new_bloc/models/finalQuesion.dart';
import 'package:new_new_bloc/Screens/loginScreen.dart';



import 'package:shared_preferences/shared_preferences.dart';








class AutoShowSurvey extends StatefulWidget {
  @override
  _AutoShowSurveyState createState() => _AutoShowSurveyState();
}

class _AutoShowSurveyState extends State<AutoShowSurvey> {



  //FutureBuilder






  //List<finalQuestion> finalqlist;
  bool gotList = false;
  String inputtext;
  final _formKey = GlobalKey<FormState>();
  TextTypeInput kbt;

  String optionvalue;


  @override
  Widget build(BuildContext context) {

    //String dropdownval = null;

    // TODO: implement build
    return Scaffold(
      body: FutureBuilder(
        initialData: [],

        builder: (context, finalqlist){
          if(finalqlist.connectionState==ConnectionState.waiting){
            return Container(
              color: Colors.teal,
              child: Center(
                child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
            );
          }
          return Column(
            //shrinkWrap: true,

            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                height: 100,
                width: double.infinity,
                color: Colors.teal,
                child: Text(
                  'SURVEY FORM',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                    letterSpacing: 3.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: ListView.builder(
                      shrinkWrap: true,
                      //itemCount: finalqlist.length,
                      itemCount: finalqlist.data.length,
                      itemBuilder: (context, int index) {



                        return ((finalqlist.data[index].type == "number" ||
                            finalqlist.data[index].type == 'text')
                            ? TextTypeInput(
                          isPassword: false,
                          placeholder: finalqlist.data[index].question,
                          icon: Icons.ac_unit,
                          kbtype: finalqlist.data[index].type == 'text'
                              ? TextInputType.text
                              : TextInputType.number,
                          onSaved: (String val) {
                            setState(() {
                              finalqlist.data[index].answer=(val)  ;
                            });
                          },
                          validator: (String val) {
                            if (finalqlist.data[index].required) {
                              if (val.isEmpty) {
                                return ('This ${finalqlist.data[index].type} can not be empty');
                              }
                            }
                          },
                        )
                            : (finalqlist.data[index].type=='multiple choice')?
                        MultipleChoiceListBuilder(sampleData: finalqlist.data[index].options,title: finalqlist.data[index].question, question: finalqlist.data[index],)


                            :(finalqlist.data[index].type=="dropdown")?
                        DropDownInput(
                          placeholder: finalqlist.data[index].question,
                          options: finalqlist.data[index].options,
                          selectedOption: null,
                          question: finalqlist.data[index],

                        ):CheckBoxListBuilder(
                          sampleData: finalqlist.data[index].options,title: finalqlist.data[index].question, question: finalqlist.data[index],)
                        );
                      }),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  RaisedButton(
                    onPressed: () {

                      bool isWrong = false;
                      int name;
                      if(_formKey.currentState.validate()){
                        _formKey.currentState.save();
                        for(int i = 0; i<finalqlist.data.length; i++){
                          print("<---- ${finalqlist.data[i].answer}------>");
                        }
                      }


                    },
                    child: Text("save"),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.remove('token');
                      Navigator.push(context, new MaterialPageRoute(
                          builder: (context)=> LoginScreen()));
                    },
                    color: Colors.red,
                    child: Text('LogOut', style: TextStyle(
                        color: Colors.white
                    ),),
                  ),


                ],
              ),
            ],
          );




        },
        future: fetchSurvey(),
      ),
    );
  }


}






