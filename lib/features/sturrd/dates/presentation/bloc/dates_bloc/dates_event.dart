import 'package:equatable/equatable.dart';
import 'package:sturrd_flutter/features/sturrd/dates/data/datasources/dates_data_remote_datasource.dart';


abstract class DatesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetDatesListFromDatabase extends DatesEvent {
  final Dates label;

  GetDatesListFromDatabase(this.label);
  @override
  List<Object> get props => [label];
}


class GetDatesListStreamFromDatabase extends DatesEvent {
  final Dates label;

  GetDatesListStreamFromDatabase(this.label);
  @override
  List<Object> get props => [label];
}