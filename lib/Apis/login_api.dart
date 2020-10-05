import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login_api{
  void validateLogin(){
    print("DOEEEE");
  }
}





  Future<String> userLogin(String name, String password) async{
  print('dhuksi');
    final String apiUrl = 'http://arfab.sytes.net:8080/login';
    final String header = 'application/json';

    final body = jsonEncode({
      'username' : name,
      'password' : password,
    });

    try{
      final response = await http.post(apiUrl,
          headers: {
            'Content-Type' : header,
          },body: body);

      final String responsebody = response.body;
      print(response);
      //print(responsebody);
      if(response.statusCode == 200){
        Map<String, dynamic> m = json.decode(response.body);
        //print(m);
        String token = m['body']['token'];
        print(token);
        //print(token);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);
        return token;
      }
      return null;

    }catch(e){
      print(e);
    }
  }
  //print('done');

