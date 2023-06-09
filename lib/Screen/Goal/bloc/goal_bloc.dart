// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:days_21/Data/Repository/sing_avatar_repository.dart';
import 'package:days_21/common/exception.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'goal_event.dart';
part 'goal_state.dart';

class GoalBloc extends Bloc<GoalEvent, GoalState> {
  final ISingAvatarRepository singAvatarRepository;
  GoalBloc(this.singAvatarRepository) : super(GoalInitial()) {
    on<GoalEvent>((event, emit) async {
      try {
        if (event is GoalSubmitButtonClickEvent) {
          emit(GoalSubmitLoadingState());
          await singAvatarRepository.updateGoals(event.goalsId);
          emit(GoalSubmitSuccessState());
        }
      } catch (error) {
        // ignore: deprecated_member_use
        if (error is DioError) {
          Map<String, dynamic> errorResponse = error.response!.data["errors"];
          String firstErrorMessage = '';

          errorResponse.forEach((key, value) {
            if (value.isNotEmpty) {
              firstErrorMessage = value[0];
              return;
            }
          });
          emit(GoalSubmitErrorState(AppException(message: firstErrorMessage)));
        }
      }
    });
  }
}
