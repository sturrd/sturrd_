import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';

class DatesListStream extends Equatable {
Stream<Event> list;
 

  DatesListStream({
    @required this.list,
  });

  @override
  List<Object> get props => [list];
}
