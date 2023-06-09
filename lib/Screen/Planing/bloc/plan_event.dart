part of 'plan_bloc.dart';

abstract class PlanEvent extends Equatable {
  const PlanEvent();

  @override
  List<Object> get props => [];
}

class PlanStartEvent extends PlanEvent {}

class PlanBuyingButtonEvent extends PlanEvent {
  final int planId;

  const PlanBuyingButtonEvent(this.planId);
}
