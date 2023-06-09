// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:days_21/Data/Model/plans_response.dart';
import 'package:days_21/Data/Model/user_reponse.dart';
import 'package:days_21/Data/Repository/planing_repository.dart';
import 'package:days_21/common/exception.dart';
import 'package:equatable/equatable.dart';

part 'plan_event.dart';
part 'plan_state.dart';

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  final IPlaningRepository planingRepository;
  PlanBloc(this.planingRepository) : super(PlanInitial()) {
    on<PlanEvent>((event, emit) async {
      try {
        if (event is PlanStartEvent) {
          emit(PlanLoadingState());
          final user = await planingRepository.getUser();
          final plans = await planingRepository.getPlans();
          emit(PlanSuccessSate(user, plans));
        } else if (event is PlanBuyingButtonEvent) {
          emit(PlanBuyingLoadingState());
          final url = await planingRepository.buyPlan(event.planId);
          emit(PlanBuyingSuccessSatet(url));
        }
      } catch (error) {
        emit(PlanLoadingError(AppException(message: 'خطای نا مشخص')));
      }
    });
  }
}
