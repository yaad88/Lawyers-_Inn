import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_new_bloc/Blocs/mail_bloc_cubit.dart';
import 'package:new_new_bloc/Blocs/password_bloc_cubit.dart';
import 'package:new_new_bloc/Blocs/login_bloc_cubit.dart';
import 'package:new_new_bloc/Screens/autoSurveyScreen.dart';
import 'package:new_new_bloc/Screens/secondPage.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<MailBlocCubit>(
          create: (context)=> MailBlocCubit()),
      BlocProvider<PasswordBlocCubit>(
        create: (context)=> PasswordBlocCubit(),
      ),
      BlocProvider<LoginBlocCubit>(
          create: (context)=>LoginBlocCubit())
    ]


        ,
        child:MaterialApp(
          home: showLogin(),

        ) );
  }
}

class showLogin extends StatefulWidget {
  @override
  _showLoginState createState() => _showLoginState();
}

class _showLoginState extends State<showLogin> {
  String errorText = null;
  MailBlocState globalMailState= MailBlocState();
  PasswordBlocState globalPassState = PasswordBlocState();
  TextEditingController ec = TextEditingController();
  TextEditingController pc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MailBlocCubit mailBloc = BlocProvider.of<MailBlocCubit>(context);
    PasswordBlocCubit passBloc = BlocProvider.of<PasswordBlocCubit>(context);
    LoginBlocCubit loginBloc = BlocProvider.of<LoginBlocCubit>(context);
    return
        Scaffold(
          appBar: AppBar(
            title: Text('Laywers\' Inn'),
            centerTitle: true,
          ),
          body: BlocListener<LoginBlocCubit, LoginBlocState>(
            listener: (context, loginState){
              if(loginState is LoginBlocFailed){
                Scaffold.of(context).showSnackBar(
                 SnackBar(
                  backgroundColor: Colors.red,
                  content: (Text(
                    'Creds Invalid',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white
                    ),
                  )
                  ),
                 )
                );
              }

              if (loginState is LoginBlocSuccess){
                //print('gese');
                Navigator.push(context, new MaterialPageRoute(builder: (context)=> AutoShowSurvey()));
              }
            },
            child: Container(
              padding: EdgeInsets.all(20),
              child: BlocBuilder<MailBlocCubit, MailBlocState>(
                  builder: (context, mailState){
                    return Container(
                      child:
                        BlocBuilder<PasswordBlocCubit, PasswordBlocState>
                          (builder: (context, passState){
                            return Container(
                              child: BlocBuilder<LoginBlocCubit, LoginBlocState>
                                (builder: (context, loginState){
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextField(
                                        controller: ec,

                                        onChanged: (value){
                                          mailBloc.checkMail(value);
                                        },
                                        decoration: InputDecoration(
                                            labelText: 'Give Mail',
                                            hintText: 'mail must be valid',
                                            border: OutlineInputBorder(),

                                            errorText: (!(mailState is MailBlocInvalid))?null:'mail invalid',
                                          suffixIcon: Icon(Icons.accessibility)
                                        ),
                                      ),
                                      SizedBox(height: 20,),
                                      TextField(
                                        controller: pc,
                                        obscureText: true,
                                        onChanged: (value){
                                          passBloc.checkPass(value);
                                        },
                                        decoration: InputDecoration(
                                            labelText: 'Give Password',
                                            hintText: 'Password Length has to be minimum 3',
                                            border: OutlineInputBorder(),
                                            errorText: (!(passState is PasswordBlocInvalid))?null:'pass invalid',
                                          suffixIcon: Icon(Icons.adb),

                                        ),
                                      ),
                                      SizedBox(height: 20,),
                                      (loginState is LoginBlocLoading)?CircularProgressIndicator(
                                        strokeWidth: 10,
                                        backgroundColor: Colors.green,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                                      ):
                                      RaisedButton(
                                        color: Colors.green,
                                        textColor: Colors.white,
                                        child: Text('Login!'),
                                        onPressed: (passState is PasswordBlocValid && mailState is MailBlocValid)?()=>loginBloc.getToken(ec.text, pc.text):null,
                                      )
                                    ],
                                  );
                              }),

                            );
                        })

                    );
                  },
                  ),
            ),
          ),
        );


      /*Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        //color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<MailBlocCubit,MailBlocState>(
              builder: (context, mailState){
                globalMailState = mailState;
                return  TextField(
                  controller: ec,

                    onChanged: (value){
                      mailBloc.checkMail(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Give Mail',
                      hintText: 'mail must be valid',
                      border: OutlineInputBorder(),

                      errorText: (mailState is MailBlocValid)?null:'mail invalid'
                    ),
                  );

              },
            ),
            SizedBox(
              height: 20,
            ),
            BlocBuilder<PasswordBlocCubit, PasswordBlocState>(
              builder: (context, passState){
                globalPassState = passState;
                return TextField(
                  controller: pc,
                  obscureText: true,
                  onChanged: (value){
                    passBloc.checkPass(value);
                  },
                  decoration: InputDecoration(
                    labelText: 'Give Password',
                    hintText: 'Must be more than 3',
                    border: OutlineInputBorder(),
                    errorText: (passState is PasswordBlocValid)?null:'pass invalid'
                  ),
                );
              },
            ),
            SizedBox(height: 20,),
            BlocBuilder<LoginBlocCubit, LoginBlocState>(
              builder: (context, loginState){
                //print(globalPassState);
                //print(globalMailState);
                return RaisedButton(
                  child: Text('Login!'),
                  onPressed:()=>loginBloc.getToken(ec.text, pc.text),
                );
              },
            )
          ],
        ),

      ),
    );*/
  }
}

