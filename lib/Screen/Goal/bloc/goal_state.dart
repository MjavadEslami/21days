part of 'goal_bloc.dart';

abstract class GoalState extends Equatable {
  const GoalState();

  @override
  List<Object> get props => [];
}

class GoalInitial extends GoalState {}

class GoalSubmitLoadingState extends GoalState {}

class GoalSubmitSuccessState extends GoalState {}

class GoalSubmitErrorState extends GoalState {
  final AppException exception;

  const GoalSubmitErrorState(this.exception);
  @override
  List<Object> get props => [exception];
}
