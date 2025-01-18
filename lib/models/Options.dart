class Options {
  int id;
  String? description;//option..
  int? question_id;
  bool is_correct;
  bool unanswered;

  Options({
    required this.id,
    required this.description,
    required this.question_id,
    required this.is_correct,
    required this.unanswered
  });

  factory Options.fromJson(Map<String,dynamic> json){
    return Options(
    id: json['id'], 
    description: json['description'], 
    question_id: json['question_id'], 
    is_correct: json['is_correct'], 
    unanswered: json['unanswered']
    );
  }
}