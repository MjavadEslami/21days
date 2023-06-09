part of 'goal_bloc.dart';

abstract class GoalEvent extends Equatable {
  const GoalEvent();

  @override
  List<Object> get props => [];
}

class GoalSubmitStartEvent extends GoalEvent {}

class GoalSubmitButtonClickEvent extends GoalEvent {
  final List<int> goalsId;

  const GoalSubmitButtonClickEvent(this.goalsId);
}
