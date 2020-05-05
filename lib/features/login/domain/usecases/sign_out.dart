import 'package:dartz/dartz.dart';
import 'package:sturrd_flutter/core/error/failures.dart';
import 'package:sturrd_flutter/core/usecases/usecase.dart';
import 'package:sturrd_flutter/features/login/domain/entities/user.dart';
import 'package:sturrd_flutter/features/login/domain/repositories/login_repository.dart';

class RemoveUserBySigningOut implements UseCase<User, Params> {
  final LoginRepository repository;

  RemoveUserBySigningOut(this.repository);

  @override
  Future<Either<Failure, User>> call(Params params) async {
    return await repository.signOut();
  }
}