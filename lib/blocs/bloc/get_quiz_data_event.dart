part of 'get_quiz_data_bloc.dart';

sealed class GetQuizDataEvent extends Equatable {
  const GetQuizDataEvent();

  @override
  List<Object> get props => [];
}
class GetQuizData extends GetQuizDataEvent{}

