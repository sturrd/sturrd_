import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:sturrd_flutter/features/sturrd/domain/entities/dates_list.dart';
import 'package:sturrd_flutter/features/sturrd/domain/entities/dates_list_stream.dart';

abstract class DatesState extends Equatable {
  @override
  List<Object> get props => [];
}

class DatesInitial extends DatesState {
  @override
  List<Object> get props => [];
}

class DatesInitializing extends DatesState {}

class DatesInitialized extends DatesState {
  final DatesListStream datesListStream;
  DatesInitialized({@required this.datesListStream});
  @override
  List<Object> get props => [datesListStream];
}

class ErrorDatesState extends DatesState {
  final String message;

  ErrorDatesState({@required this.message});
}
