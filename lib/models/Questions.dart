
import 'package:testline_ass/models/Options.dart';

class Questions {
  int id;
  String? description;//question..
  String? topic;
  String? detailed_solution;
  List<Options> options;

  Questions({
    required this.id,
    required this.description,
    required this.topic,
    required this.detailed_solution,
    required this.options
  });

  factory Questions.fromJson(Map<String,dynamic> json){
    return Questions(
      id: json['id'], 
      description: json['description'], 
      topic: json['topic'], 
      detailed_solution: json['detailed_solution'], 
      options: (json['options'] as List<dynamic>)
        .map((option) => Options.fromJson(option))
        .toList());
  }


}