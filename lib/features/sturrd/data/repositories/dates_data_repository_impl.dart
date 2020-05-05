import 'package:dartz/dartz.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sturrd_flutter/core/error/exceptions.dart';
import 'package:sturrd_flutter/core/error/failures.dart';
import 'package:sturrd_flutter/core/network_info/network_info.dart';
import 'package:sturrd_flutter/features/sturrd/data/datasources/dates_data_remote_datasource.dart';
import 'package:sturrd_flutter/features/sturrd/domain/entities/dates_list.dart';
import 'package:sturrd_flutter/features/sturrd/domain/entities/dates_list_stream.dart';
import 'package:sturrd_flutter/features/sturrd/domain/repositories/dates_data_repository.dart';
import 'package:meta/meta.dart';

class DatesDataRepositoryImpl implements DatesDataRepository {
  final DatesDataRemoteDataSource datesDataRemoteDataSource;
  final NetworkInfo networkInfo;

  DatesDataRepositoryImpl(
      {@required this.datesDataRemoteDataSource, @required this.networkInfo});

  @override
  Future<Either<Failure, DatesList>> getDatesFromDatabase(
      Dates label) async {
    if (await networkInfo.isConnected) {
      try {
        final topicsList =
            await datesDataRemoteDataSource.getDatesFromDatabase(label);
        return Right(topicsList);
      } on Exception {
        return Left(ServerFailure());
      }
    } else {
      try {
        Fluttertoast.showToast(
            msg: 'Check your internet connection',
            toastLength: Toast.LENGTH_LONG);
        throw new ConnectionException();
      } on ConnectionException {
        return Left(ConnectionFailure());
      }
    }
  }

  @override
  Future<Either<Failure, DatesListStream>> getDatesStreamFromDatabase(
      Dates label) async {
    if (await networkInfo.isConnected) {
      try {
        final topicsListStream =
            await datesDataRemoteDataSource.getDatesStreamFromDatabase(label);
        return Right(topicsListStream);
      } on Exception {
        return Left(ServerFailure());
      }
    } else {
      try {
        Fluttertoast.showToast(
            msg: 'Check your internet connection',
            toastLength: Toast.LENGTH_LONG);
        throw new ConnectionException();
      } on ConnectionException {
        return Left(ConnectionFailure());
      }
    }
  }
}
