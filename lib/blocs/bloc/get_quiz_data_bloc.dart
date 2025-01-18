import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:testline_ass/models/Quiz.dart';
import 'package:testline_ass/services/QuizService.dart';

part 'get_quiz_data_event.dart';
part 'get_quiz_data_state.dart';

class GetQuizDataBloc extends Bloc<GetQuizDataEvent, GetQuizDataState> {
  final QuizService quizService;
  GetQuizDataBloc(this.quizService) : super(GetQuizDataInitial()) {

    on<GetQuizData>(GetData);
  }

  Future<void> GetData(GetQuizData event,Emitter<GetQuizDataState>emit)async{
    log('getting data is started...');
    try{
      emit(Loading());
      final responseJson = await quizService.fetchQuizData();
      log("got the respose dara...");
      emit(QuizDataSucess(data: responseJson));

      
    }catch(error){
      log("Smtg wrong in bloc service..");
      emit(FailedGettinQuizData(msg:error.toString()));
      print(error.toString());
    }
    
  }
}


