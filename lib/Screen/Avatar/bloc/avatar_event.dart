part of 'avatar_bloc.dart';

abstract class AvatarEvent extends Equatable {
  const AvatarEvent();

  @override
  List<Object> get props => [];
}

class AvatarStartEvent extends AvatarEvent {}

class AvatarButtonClickedEvent extends AvatarEvent {
  final String name;
  final int imageId;

  const AvatarButtonClickedEvent(this.name, this.imageId);
}
