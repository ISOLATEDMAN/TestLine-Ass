import 'package:testline_ass/models/Questions.dart';

class Quiz {
  int id;
  String? name;
  String? title;
  String? topic;
  int? duration;
  String negative_marks;
  String correct_answer_marks;
  int questions_count;
  int? max_mistake_count;
  List<Questions> questions;

  Quiz({
    required this.id,
    required this.name,
    required this.title,
    required this.topic,
    required this.duration,
    required this.negative_marks,
    required this.correct_answer_marks,
    required this.questions_count,
    required this.max_mistake_count,
    required this.questions,
  });


  factory Quiz.fromJson(Map<String,dynamic> json){
    return Quiz(
      id: json['id'],
      name: json['name'], 
      title: json['title'], 
      topic: json['topic'], 
      duration: json['duration'], 
      negative_marks: json['negative_marks'], 
      correct_answer_marks: json['correct_answer_marks'], 
      questions_count: json['questions_count'], 
      max_mistake_count: json['max_mistake_count'], 
      questions: (json['questions'] as List<dynamic>).map((questions)=>Questions.fromJson(questions)).toList(),
      );
  }

}