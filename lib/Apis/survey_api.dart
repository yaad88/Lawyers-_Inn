import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:new_new_bloc/models/Question.dart';
import 'package:http/http.dart' as http;

import 'package:new_new_bloc/models/finalQuesion.dart';
import 'package:new_new_bloc/Screens/loginScreen.dart';

import 'package:new_new_bloc/Widgets/allWidgets.dart';

import 'package:shared_preferences/shared_preferences.dart';

Future<List<dynamic>> fetchSurvey() async {
  try {
    List<Question> qlist;
    List<finalQuestion> finalqlist = List<finalQuestion>();
    final String url = 'http://arfab.sytes.net:8080/survey';
    //final String token = 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6ImFhcDE0MyJ9.90TyHEsB8939B7XsSRrd0N-gJPyek7n7arHyBV-Gqgk';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    //String token = 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6ImZvbyJ9.G9l_xczIaV97MVaOGoERmZJC4TQNV0mhuAAMtG-9vvw';

    final response = await http.get(url,
        headers: {'Authorization': token, 'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      //print(response.body);
      Map<String, dynamic> m = json.decode(response.body);
      //print(m);
      List<dynamic> l = m['body'];
      //print(l);
      qlist = l.map((eachdata) => Question.fromJson(eachdata)).toList();
      //finalqlist.length = qlist.length;
      finalqlist = finalqlist.toList();

      //print(finalqlist.isEmpty);
      //print(qlist.length);
      //print(qlist[0].options);
      for (int index = 0; index < qlist.length; index++) {
        Question thisq = qlist[index];
        //print(thisq.type);
        List<String> options;
        List<RadioModel> RadioOptions = List<RadioModel>();
        if (qlist[index].type == 'multiple choice' ||
            qlist[index].type == 'checkbox' ||
            qlist[index].type == 'dropdown') {
          String opstring = qlist[index].options;
          options = opstring.split(',').toList();
          for(int k = 0; k<options.length; k++){
            RadioModel option = RadioModel(
              isSelected:false,
              text: options[k],

            );

            RadioOptions.add(option);

          }


          //print(options);
        }
        finalQuestion quesob = finalQuestion(
          id: thisq.id,
          required: thisq.required,
          type: thisq.type,
          question: thisq.question,
          options: RadioOptions,
          answer: null,
        );

        finalqlist.add(quesob);
        //print(finalqlist[index].options);
      }
      //print(qlist);

      return finalqlist;
    } else {
      print(response.statusCode);
    }
    // else{
    //   throw Exception("ERROR ON SIDE");
    // }

  } catch (e) {
    print(e);
  }
}