import 'dart:convert';
import 'package:new_new_bloc/Widgets/MultipleChoiceBuilder.dart';
import 'package:new_new_bloc/Widgets/RadioModel.dart';




class finalQuestion{
  final num id;
  final String question;
  final String type;
  final List<RadioModel> options;
  final bool required;

   String answer;

  finalQuestion({this.id, this.options, this.question, this.required, this.type, this.answer});




}