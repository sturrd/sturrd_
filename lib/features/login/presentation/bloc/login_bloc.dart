import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sturrd_flutter/core/error/failures.dart';
import 'package:sturrd_flutter/features/login/domain/entities/user.dart';

import './bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_user_from_phone_auth_sign_in.dart';
import '../../domain/usecases/sign_out.dart';

const String LOGIN_FAILURE_MESSAGE = 'Authentication Failure';
const String CONNECTION_FAILURE_MESSAGE = 'Check your internet connection';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final GetUserFromPhoneAuthSignIn getUserFromPhoneAuthSignIn;
  final RemoveUserBySigningOut removeUserBySigningOut;

  LoginBloc(
      {@required this.getUserFromPhoneAuthSignIn,
      @required this.removeUserBySigningOut});
  @override
  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is VerifyPhoneNumberEvent) {
      loginInputBloc.addShowSMSOTP(true);
      yield AuthenticatingLoginState();
      try {
        final failureOrUser = await getUserFromPhoneAuthSignIn(Params(
            auth: FirebaseAuth.instance,
            firestore: Firestore.instance,
            googleSignIn: GoogleSignIn()));
        yield* _eitherLoadedOrErrorState(failureOrUser);
      } catch (e) {
        print(e);
      }
    }
  }

  Stream<LoginState> _eitherLoadedOrErrorState(
    Either<Failure, User> failureOrUser,
  ) async* {
    yield failureOrUser.fold(
      (failure) => ErrorLoginState(message: _mapFailureToMessage(failure)),
      (user) => AuthenticatedLoginState(loggedInUser: user),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case LoginFailure:
        return LOGIN_FAILURE_MESSAGE;
      case ConnectionFailure:
        return CONNECTION_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}

class LoginInputBloc {
  //
  final BehaviorSubject _controller = BehaviorSubject();
  //stream
  String get phoneNumber => _controller.stream.value;
  //sink
  Function(String) get addPhoneNumber => _controller.sink.add;

  //controller for sms verification
  final BehaviorSubject _verificationIdController = BehaviorSubject();
  //stream
  String get verificationId => _verificationIdController.stream.value;
  //sink
  Function(String) get addVerificationId => _verificationIdController.sink.add;

  //sms for sms OTP
  final BehaviorSubject _smsOTPController = BehaviorSubject();
//stream
  String get smsOTP => _smsOTPController.stream.value;
  //sink
  Function(String) get addsmsOTP => _smsOTPController.sink.add;

  //controller for error message
  final BehaviorSubject _errorMessageController = BehaviorSubject();
  String get errorMessage => _errorMessageController.stream.value;
  //sink
  Function(String) get addErrorMessage => _errorMessageController.sink.add;

  //controller
  final BehaviorSubject _showSmsOTPController = BehaviorSubject<bool>();
  bool get showSMSOTP => _showSmsOTPController.stream.value;
  Function(bool) get addShowSMSOTP => _showSmsOTPController.sink.add;

  dispose() {
    _controller.close();
    _verificationIdController.close();
    _smsOTPController.close();
    _errorMessageController.close();
    _showSmsOTPController.close();
  }
}

final loginInputBloc = LoginInputBloc() ..addShowSMSOTP(false);
