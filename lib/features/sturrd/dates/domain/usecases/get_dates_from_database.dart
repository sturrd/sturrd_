import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:sturrd_flutter/features/sturrd/dates/domain/entities/dates_list.dart';
import 'package:sturrd_flutter/features/sturrd/dates/domain/repositories/dates_data_repository.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';


class GetDatesFromDatabase extends UseCase<DatesList,Params>{
  final DatesDataRepository repository;

  GetDatesFromDatabase({@required this.repository});

   @override
  Future<Either<Failure, DatesList>> call(Params params) async {
    return await repository.getDatesFromDatabase(params.label);
  }
}


