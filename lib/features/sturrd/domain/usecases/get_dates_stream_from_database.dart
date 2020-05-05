import 'package:dartz/dartz.dart';
import 'package:sturrd_flutter/features/sturrd/domain/entities/dates_list_stream.dart';
import 'package:sturrd_flutter/features/sturrd/domain/repositories/dates_data_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

import 'package:meta/meta.dart';

class GetDatesStreamFromDatabase extends UseCase<DatesListStream,Params>{
  final DatesDataRepository repository;

  GetDatesStreamFromDatabase({@required this.repository});

   @override
  Future<Either<Failure, DatesListStream>> call(Params params) async {
    return await repository.getDatesStreamFromDatabase(params.label);
  }
}
