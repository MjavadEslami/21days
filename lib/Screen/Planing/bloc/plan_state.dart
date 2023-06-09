part of 'plan_bloc.dart';

abstract class PlanState extends Equatable {
  const PlanState();

  @override
  List<Object> get props => [];
}

class PlanInitial extends PlanState {}

class PlanLoadingState extends PlanState {}

class PlanSuccessSate extends PlanState {
  final User user;
  final PlansResponse plans;

  const PlanSuccessSate(this.user, this.plans);
}

class PlanLoadingError extends PlanState {
  final AppException exception;

  const PlanLoadingError(this.exception);
}

class PlanBuyingLoadingState extends PlanState {}

class PlanBuyingSuccessSatet extends PlanState {
  final String bankGetWay;

  const PlanBuyingSuccessSatet(this.bankGetWay);
}
