import 'dart:convert';

Question questionFromJson(String str){
  return Question.fromJson(json.decode(str));
}


class Question{
  final num id;
  final String question;
  final String type;
  final String options;
  final bool required;

  Question({this.id, this.options, this.question, this.required, this.type});

  factory Question.fromJson(Map<String, dynamic> json){
    return Question(
      id:json['id'],
      question: json['question'],
      type: json['type'],
      required: json['required'],
      options: json['options'],

    );
  }


}