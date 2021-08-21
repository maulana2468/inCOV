import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'anim_event.dart';
part 'anim_state.dart';

class SetAnimBloc extends Bloc<SetAnimEvent, SetAnimState> {
  SetAnimBloc() : super(SetAnimInitial());

  @override
  Stream<SetAnimState> mapEventToState(
    SetAnimEvent event,
  ) async* {
    if (event is Slide) {
      if (state is SetAnimInitial) {
        yield SetAnimValue(99);
      } else if ((state as SetAnimValue).index == event.index) {
        yield SetAnimValue(99);
      } else {
        yield SetAnimValue(event.index);
      }
    }
  }
}

class SetAnim2Bloc extends Bloc<SetAnimEvent, SetAnimState> {
  SetAnim2Bloc() : super(SetAnim2Initial());

  @override
  Stream<SetAnimState> mapEventToState(
    SetAnimEvent event,
  ) async* {
    if (event is SlideFindProv) {
      if (state is SetAnim2Initial) {
        yield SetAnim2Value("");
      } else if ((state as SetAnim2Value).provId == event.provId) {
        yield SetAnim2Value("");
      } else {
        yield SetAnim2Value(event.provId);
      }
    }
  }
}
