// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:days_21/Data/Model/avatars_goals_response.dart';
import 'package:days_21/Data/Repository/sing_avatar_repository.dart';
import 'package:days_21/common/exception.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'avatar_event.dart';
part 'avatar_state.dart';

class AvatarBloc extends Bloc<AvatarEvent, AvatarState> {
  final ISingAvatarRepository singAvatarRepository;
  AvatarBloc(this.singAvatarRepository) : super(AvatarInitial()) {
    on<AvatarEvent>((event, emit) async {
      try {
        if (event is AvatarStartEvent) {
          emit(AvatarLoadState());
          final response = await singAvatarRepository.getData();
          emit(AvatarSuccessState(response));
        } else if (event is AvatarButtonClickedEvent) {
          emit(AvatarUpdateProfileLoadingState());
          await singAvatarRepository.regiserNameAndAvatar(
              event.name, event.imageId);
          final response = await singAvatarRepository.getData();
          emit(AvatarUpdateProfileSuccessState(response));
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
          emit(AvatarErrorState(AppException(message: firstErrorMessage)));
        }
      }
    });
  }
}
