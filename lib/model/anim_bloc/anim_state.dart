part of 'anim_bloc.dart';

@immutable
abstract class SetAnimState {}

class SetAnimInitial extends SetAnimState {}

class SetAnim2Initial extends SetAnimState {}

class SetAnimValue extends SetAnimState {
  final int index;

  SetAnimValue(this.index);

  List<Object> get props => [index];
}

class SetAnim2Value extends SetAnimState {
  final String provId;

  SetAnim2Value(this.provId);

  List<Object> get props => [provId];
}
