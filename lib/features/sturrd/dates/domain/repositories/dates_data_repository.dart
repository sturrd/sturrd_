import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:sturrd_flutter/features/sturrd/dates/data/datasources/dates_data_remote_datasource.dart';

import '../../../../../core/error/failures.dart';
import '../entities/dates_list.dart';
import '../entities/dates_list_stream.dart';



abstract class DatesDataRepository{
  //data from collection.
  Future<Either<Failure,DatesList>> getDatesFromDatabase(Dates label);
  Future<Either<Failure,DatesListStream>> getDatesStreamFromDatabase(Dates label);

}