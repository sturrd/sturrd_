import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network_info/network_info.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/firebase_remote_datasource.dart';

class LoginRepositoryImpl implements LoginRepository {
  final FirebaseRemoteDataSource firebaseRemoteDataSource;
  final NetworkInfo networkInfo;

  LoginRepositoryImpl(
      {@required this.firebaseRemoteDataSource, @required this.networkInfo});
  @override
  Future<Either<Failure, User>> getUserFromPhoneAuthSignIn(
      Params params) async {
    if (await networkInfo.isConnected) {
      try {
        GoogleSignInAccount googleSignInAccount =
            await params.googleSignIn.signIn();
        GoogleSignInAuthentication googleAuth =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.getCredential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        FirebaseUser user = await firebaseRemoteDataSource.getCurrentUser();
        if (user != null) {
          return Right(User(user: user));
        }
        user = await firebaseRemoteDataSource
            .getUserFromPhoneAuthSignIn(credential);
        updateUserData(user);

        return Right(User(user: user));
      } on LoginException {
        return Left(LoginFailure());
      }
    } else {
      try {
        throw new ConnectionException();
      } on ConnectionException {
        return Left(ConnectionFailure());
      }
    }
  }

  @override
  Future<Either<Failure, User>> signOut() async {
    try {
      await firebaseRemoteDataSource.signOut();
      return (Right(User(user: null)));
    } on SignOutException {
      return (Left(SignOutFailure()));
    }
  }

  @override
  Future<Either<Failure, User>> updateUserData(FirebaseUser user) {
    // TODO: implement updateUserData
    throw UnimplementedError();
  }
}
