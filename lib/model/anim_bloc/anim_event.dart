part of 'anim_bloc.dart';

@immutable
abstract class SetAnimEvent {}

class Slide extends SetAnimEvent {
  final int index;

  Slide(this.index);
}

class SlideFindProv extends SetAnimEvent {
  final String provId;

  SlideFindProv(this.provId);
}
