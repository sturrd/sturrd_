import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/mockito.dart';
import 'package:sturrd_flutter/core/usecases/usecase.dart';
import 'package:sturrd_flutter/features/login/domain/entities/user.dart';
import 'package:sturrd_flutter/features/login/domain/repositories/login_repository.dart';
import 'package:sturrd_flutter/features/login/domain/usecases/get_user_from_phone_auth_sign_in.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

class MockFirebaseUser extends Mock implements FirebaseUser {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  GetUserFromPhoneAuthSignIn getUserFromPhoneAuthSignIn;
  MockLoginRepository mockLoginRepository;
  MockFirebaseAuth tAuth;
  MockFirebaseUser tFirebaseUser;

  setUp(() => {
        getUserFromPhoneAuthSignIn =
            GetUserFromPhoneAuthSignIn(mockLoginRepository),
        tAuth = MockFirebaseAuth(),
        tFirebaseUser = MockFirebaseUser(),
      });
  final tGoogleSignIn = GoogleSignIn();
  final tFirestore = Firestore.instance;

  final params = Params(
    googleSignIn: tGoogleSignIn,
    auth: tAuth,
    firestore: tFirestore,
  );
  group(
      'Sign up with phone auth',() => {
            test('should return a firebaseuser when signs in', () async {
              //arrange
              final tUser = User(user: tFirebaseUser);

              when(mockLoginRepository.getUserFromPhoneAuthSignIn(any))
                  .thenAnswer((_) async => Right(tUser));
              //act
              final result = await getUserFromPhoneAuthSignIn(params);
              //assert
              expect(result, isNotNull);
              expect(result, equals(Right(User(user: tFirebaseUser))));
            }),
          });
}
