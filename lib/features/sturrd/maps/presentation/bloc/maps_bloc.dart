import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'maps_event.dart';
part 'maps_state.dart';

class MapsBloc extends Bloc<MapsEvent, MapsState> {
  @override
  MapsState get initialState => MapsInitial();
  @override
  Stream<MapsState> mapEventToState(
    MapsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
