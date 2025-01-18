import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:testline_ass/models/Quiz.dart';

class QuizService {
  final String baseUrl = 'https://api.jsonserve.com/Uw5CrX';
  
  Future<Quiz> fetchQuizData() async {
    final url = Uri.parse(baseUrl);

    try {
      final response = await http.get(url);
      log('Response received');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        log('Parsed JSON: $jsonResponse');

        return Quiz.fromJson(jsonResponse);
      } else {
        throw Exception(
          'Failed to fetch quiz data. Status code: ${response.statusCode}. '
          'Response body: ${response.body}',
        );
      }
    } catch (error, stackTrace) {
      log('Error fetching quiz data: $error', error: error, stackTrace: stackTrace);
      throw Exception('Error fetching quiz data: $error');
    }
  }
}
