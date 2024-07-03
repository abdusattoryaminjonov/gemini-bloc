
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class LoadHomeMessageEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class HomeSelectedImageEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class HomeRemoveImageEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class HomeInitSTTEvent extends HomeEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomeStartSTTEvent extends HomeEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomeStopSTTEvent extends HomeEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}