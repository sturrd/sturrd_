import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class DatesList extends Equatable {
List list;
 

  DatesList({
    @required this.list,
  });

  @override
  List<Object> get props => [list];
}
