import 'package:equatable/equatable.dart';

abstract class StarterPageEvent extends Equatable{
  const StarterPageEvent();
}

class StarterPageWaitEvent extends StarterPageEvent {
  @override
  List<Object?> get props => [];

}