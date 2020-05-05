import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sturrd_flutter/features/login/domain/repositories/login_repository.dart';
import 'package:sturrd_flutter/features/login/domain/usecases/sign_out.dart';


class MockLoginRepository extends Mock implements LoginRepository {}

class MockFirebaseUser extends Mock implements FirebaseUser {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}


void main(){
  TestWidgetsFlutterBinding.ensureInitialized();
  RemoveUserBySigningOut removeUserBySigningOut;
  MockLoginRepository mockLoginRepository;
  
  setUp(()=>{
    mockLoginRepository = MockLoginRepository(),
    removeUserBySigningOut = RemoveUserBySigningOut(mockLoginRepository),

  });
}