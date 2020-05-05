import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sturrd_flutter/core/error/exceptions.dart';
import 'package:sturrd_flutter/features/login/presentation/bloc/bloc.dart';

abstract class FirebaseRemoteDataSource {
  /// Fetches the firebaseUser .
  ///
  /// Throws a [LoginException] for all error codes.
  Future<FirebaseUser> getUserFromPhoneAuthSignIn(AuthCredential credential);
  Future<FirebaseUser> getCurrentUser();
  Future<void> updateUserData(FirebaseUser user);
  Future<void> signOut();
}

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  // String phoneNo;
  String smsOTP;
 //  String verificationId;
  String errorMessage = '';

   FirebaseAuth auth;

  FirebaseRemoteDataSourceImpl({@required this.auth});


  @override
  Future<FirebaseUser> getCurrentUser() async {
    return await FirebaseAuth.instance.currentUser();
  }

  @override
  Future<FirebaseUser> getUserFromPhoneAuthSignIn(AuthCredential credential) async{
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {    
            loginInputBloc.addVerificationId(verId);       
        };
            try {    
            await auth.verifyPhoneNumber(    
                phoneNumber: loginInputBloc.phoneNumber, // PHONE NUMBER TO SEND OTP    
                codeAutoRetrievalTimeout: (String verId) {    
                //Starts the phone number verification process for the given phone number.    
                //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.    
                loginInputBloc.addVerificationId(verId);    
                },    
                codeSent:    
                    smsOTPSent, // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.    
                timeout: const Duration(seconds: 20),    
                verificationCompleted: (AuthCredential phoneAuthCredential) {    
                print(phoneAuthCredential);    
                },    
                verificationFailed: (AuthException exception) {    
                print('${exception.message}');    
                });    
        }  on Exception{    
          throw LoginException();
        } 
  }

    Future<void> signOut() async {
    try {
      var user = await auth.currentUser();
      auth.currentUser().then((currentUser) => currentUser.delete());
      await auth.signOut();
      return user;
    } catch (e) {
      print(e);
      return throw SignOutException();
    }
  }

  @override
  Future<void> updateUserData(FirebaseUser user) {
     DocumentReference reportRef =
        Firestore.instance.collection('reports').document(user.uid);
    return reportRef.setData({'uid': user.uid, 'lastActivity': DateTime.now()},
        merge: true);
  }
}