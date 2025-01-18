import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testline_ass/Screens/Result.dart';
import 'package:testline_ass/Widgets/QuestionOpt.dart';
import 'package:testline_ass/blocs/bloc/get_quiz_data_bloc.dart';
import 'package:sizer/sizer.dart';

class Quizpages extends StatefulWidget {
  const Quizpages({super.key});

  @override
  State<Quizpages> createState() => _QuizpagesState();
}

class _QuizpagesState extends State<Quizpages> with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  int score = 0;
  DateTime? startTime;
  String elapsedTime = '00:00';
  late AnimationController _progressController;
  
  @override
  void initState() {
    super.initState();
    startTime = DateTime.now();
    _startTimer();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  void _startTimer() {
    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          Duration duration = DateTime.now().difference(startTime!);
          int minutes = duration.inMinutes;
          int seconds = (duration.inSeconds % 60);
          elapsedTime = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
        });
        _startTimer();
      }
    });
  }

  void handleAnswer(bool isCorrect) {
    if (isCorrect) {
      setState(() {
        score++;
      });
      log("correct ans");
    }
    
    setState(() {
      currentIndex++;
      _progressController.forward(from: 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetQuizDataBloc, GetQuizDataState>(
        builder: (context, state) {
          if (state is QuizDataSucess) {
            final questions = state.data.questions;

            if (currentIndex >= questions.length) {
              final Duration totalTime = DateTime.now().difference(startTime!);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Result(
                      score: score,
                      timeTaken: totalTime, 
                    ),
                  ),
                );
              });
              return const Center(child: CircularProgressIndicator());
            }

            final currentQuestion = questions[currentIndex];
            final progress = (currentIndex + 1) / questions.length;
            
            return SafeArea(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.timer, size: 5.w, color: Colors.blue.shade700),
                                  SizedBox(width: 3.w),
                                  Text(
                                    elapsedTime,
                                    style: TextStyle(
                                      fontSize: 4.w,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.star, size: 5.w, color: Colors.green.shade700),
                                  SizedBox(width: 3.w),
                                  Text(
                                    'Score: $score',
                                    style: TextStyle(
                                      fontSize: 4.w,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        Stack(
                          children: [
                            Container(
                              height: 1.h,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              height: 1.h,
                              width: MediaQuery.of(context).size.width * progress,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade700,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          'Question ${currentIndex + 1} of ${questions.length}',
                          style: TextStyle(
                            fontSize: 3.5.w,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Questionopt(
                      options: currentQuestion.options,
                      question: currentQuestion.description.toString(),
                      onAnsweredCrct: handleAnswer,
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
