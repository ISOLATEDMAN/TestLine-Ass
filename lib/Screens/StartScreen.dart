import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testline_ass/Screens/QuizPages.dart';
import 'package:testline_ass/blocs/bloc/get_quiz_data_bloc.dart';
import 'package:testline_ass/constants/AppConst.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

class Startscreen extends StatelessWidget {
  const Startscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appconst.PureWhite,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Appconst.ShadeBlue,
              Appconst.PureWhite,
            ],
          ),
        ),
        child: BlocListener<GetQuizDataBloc, GetQuizDataState>(
          listener: (context, state) {
            if (state is QuizDataSucess) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Quizpages()),
              );
            }
          },
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 6.h), 
                  Icon(
                    Icons.quiz_outlined,
                    size: 15.w, 
                    color: Colors.blue.shade700,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Welcome to Quiz Master',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 6.5.w, 
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 2.h), 
                  Text(
                    'Test your knowledge and challenge yourself!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 8.w, 
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Spacer(),

                  _buildFeatureItem(Icons.timer_outlined, 'Timed Questions'),
                  SizedBox(height: 2.h), 
                  _buildFeatureItem(Icons.emoji_events_outlined, 'Win Points'),
                  SizedBox(height: 2.h),
                  _buildFeatureItem(Icons.trending_up_outlined, 'Track Progress'),
                  Spacer(),
                  BlocBuilder<GetQuizDataBloc, GetQuizDataState>(
                    builder: (context, state) {
                      if (state is Loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ElevatedButton(
                        onPressed: () {
                          context.read<GetQuizDataBloc>().add(GetQuizData());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade700,
                          padding: EdgeInsets.symmetric(vertical: 3.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          "Start Quiz",
                          style: GoogleFonts.poppins(
                            fontSize: 5.5.w,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 5.h), 
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(3.w), 
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Colors.blue.shade700,
            size: 10.w,
          ),
        ),
        SizedBox(width: 4.w), 
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 7.w,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
