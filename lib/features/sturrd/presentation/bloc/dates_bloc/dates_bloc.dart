import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sturrd_flutter/core/error/failures.dart';
import 'package:sturrd_flutter/core/usecases/usecase.dart';
import 'package:sturrd_flutter/features/sturrd/domain/entities/dates_list.dart';
import 'package:sturrd_flutter/features/sturrd/domain/entities/dates_list_stream.dart';
import '../../../domain/usecases/get_dates_from_database.dart';
import '../../../domain/usecases/get_dates_stream_from_database.dart';
import 'dates_event.dart';
import 'dates_state.dart';

const String CONNECTION_FAILURE_MESSAGE = 'Check your connection';

class DatesBloc extends Bloc<DatesEvent, DatesState> {
  final GetDatesFromDatabase getDatesFromDatabase;
  final GetDatesStreamFromDatabase getDatesStreamFromDatabase;

  DatesBloc({
    @required this.getDatesFromDatabase,
    @required this.getDatesStreamFromDatabase,
  })  : assert(getDatesFromDatabase != null),
        assert(getDatesStreamFromDatabase != null);

  @override
  DatesState get initialState => DatesInitial();

  @override
  Stream<DatesState> mapEventToState(
    DatesEvent event,
  ) async* {
    if (event is GetDatesListFromDatabase) {
      final datesListEither =
          await getDatesFromDatabase.call(Params(label: event.label));

      // yield* datesListEither.fold((Failure failure) async* {
      //   yield ErrorDatesState(message: CONNECTION_FAILURE_MESSAGE);
      // }, (DatesList datesList) async* {
      //   yield DatesInitialized(datesList: datesList);
      // });
    } else if (event is GetDatesListStreamFromDatabase) {
      var datesStreamEither =
          await getDatesStreamFromDatabase.call(Params(label: event.label));
      yield* datesStreamEither.fold((Failure failure) async* {
        yield ErrorDatesState(message: CONNECTION_FAILURE_MESSAGE);
      }, (DatesListStream datesListStream) async* {
        yield DatesInitialized(datesListStream: datesListStream);
      });
    }
  }
}
