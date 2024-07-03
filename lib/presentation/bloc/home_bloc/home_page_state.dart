import 'package:gemini_bloc/data/models/message_model.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeInitSTTState extends HomeState {}

class HomeStartSTTState extends HomeState {}

class HomeStopSTTState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSelectedImageState extends HomeState {}

class HomeRemoveImageState extends HomeState {}

class HomeSuccessState extends HomeState {
  List<MessageModel> items;

  HomeSuccessState({required this.items});
}

class HomeFailureState extends HomeState {
  final String errorMessage;

  HomeFailureState(this.errorMessage);
}