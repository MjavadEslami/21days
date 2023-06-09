part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthSendSmsLoadingState extends AuthState {}

class AuthSendSmsSuccessState extends AuthState {}

class AuthVerfiyCodeLoadingState extends AuthState {}

class AuthVerfiyCodeSuccessState extends AuthState {
  final UserReponse userReponse;

  const AuthVerfiyCodeSuccessState(this.userReponse);
}

class AuthErrorState extends AuthState {
  final AppException exception;

  const AuthErrorState(this.exception);
  @override
  List<Object> get props => [exception];
}
