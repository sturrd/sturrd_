import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sturrd_flutter/core/error/failures.dart';
import 'package:sturrd_flutter/core/usecases/usecase.dart';
import 'package:sturrd_flutter/features/login/domain/entities/user.dart';

abstract class LoginRepository {
  Future<Either<Failure, User>> getUserFromPhoneAuthSignIn(Params params);
  Future<Either<Failure, User>> updateUserData(FirebaseUser user);
   Future<Either<Failure, User>> signOut();
}
