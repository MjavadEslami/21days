// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:days_21/Data/Model/user_reponse.dart';
import 'package:days_21/Data/Repository/auth_repository.dart';
import 'package:days_21/common/exception.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository authRepository;
  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      try {
        if (event is AuthSendSmsEvent) {
          emit(AuthSendSmsLoadingState());
          await authRepository.sendSms(event.phone);
          emit(AuthSendSmsSuccessState());
        } else if (event is AuthVerfiyCodeEvent) {
          emit(AuthVerfiyCodeLoadingState());
          final response =
              await authRepository.verfiCode(event.phone, event.code);
          emit(AuthVerfiyCodeSuccessState(response));
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
          emit(AuthErrorState(AppException(message: firstErrorMessage)));
        }
      }
    });
  }
}
