part of 'get_quiz_data_bloc.dart';

class GetQuizDataState extends Equatable {
  const GetQuizDataState();
  
  @override
  List<Object> get props => [];
}

final class GetQuizDataInitial extends GetQuizDataState {}

class Loading extends GetQuizDataState{}

class FailedGettinQuizData extends GetQuizDataState {
  final String msg;
  const FailedGettinQuizData({required this.msg});
  
  @override
  List<Object> get props => [msg];
}

class QuizDataSucess extends GetQuizDataState{
  final Quiz data;
  const QuizDataSucess({required this.data});
  @override
  List<Object> get props => [data];
}
