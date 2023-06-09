part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthStartEvent extends AuthEvent {}

class AuthSendSmsEvent extends AuthEvent {
  final String phone;

  const AuthSendSmsEvent(this.phone);
  @override
  List<Object> get props => [phone];
}

class AuthVerfiyCodeEvent extends AuthEvent {
  final String phone;
  final String code;

  const AuthVerfiyCodeEvent(this.phone, this.code);
  @override
  List<Object> get props => [phone, code];
}
