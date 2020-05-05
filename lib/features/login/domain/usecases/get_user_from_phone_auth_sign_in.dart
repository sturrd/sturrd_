import 'package:dartz/dartz.dart';
import 'package:sturrd_flutter/core/error/failures.dart';
import 'package:sturrd_flutter/core/usecases/usecase.dart';
import 'package:sturrd_flutter/features/login/domain/entities/user.dart';
import 'package:sturrd_flutter/features/login/domain/repositories/login_repository.dart';

class GetUserFromPhoneAuthSignIn implements UseCase<User, Params> {
  final LoginRepository repository;

  GetUserFromPhoneAuthSignIn(this.repository);

  @override
  Future<Either<Failure, User>> call(Params params) async {
    return await repository.getUserFromPhoneAuthSignIn(params);
  }
}