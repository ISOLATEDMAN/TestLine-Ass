import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:testline_ass/Screens/StartScreen.dart';
import 'package:testline_ass/blocs/bloc/get_quiz_data_bloc.dart';
import 'package:testline_ass/services/QuizService.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, Orientation, DeviceType) {
      return MultiBlocProvider(providers: [
        BlocProvider(create: (context)=>GetQuizDataBloc(QuizService())),
      ], child:MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Startscreen(),
      ));
  });
  }
}