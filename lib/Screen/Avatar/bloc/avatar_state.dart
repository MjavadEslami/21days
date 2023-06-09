part of 'avatar_bloc.dart';

abstract class AvatarState extends Equatable {
  const AvatarState();

  @override
  List<Object> get props => [];
}

class AvatarInitial extends AvatarState {}

class AvatarLoadState extends AvatarState {}

class AvatarSuccessState extends AvatarState {
  final AvatarsGoalsRespone avatarsGoalsRespone;

  const AvatarSuccessState(this.avatarsGoalsRespone);
}

class AvatarUpdateProfileLoadingState extends AvatarState {}

class AvatarUpdateProfileSuccessState extends AvatarState {
  final AvatarsGoalsRespone avatarsGoalsRespone;

  const AvatarUpdateProfileSuccessState(this.avatarsGoalsRespone);
}

class AvatarErrorState extends AvatarState {
  final AppException appException;

  const AvatarErrorState(this.appException);
}
