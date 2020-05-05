import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {}

//Auth Failuress
class LoginFailure extends Failure {}
class SignOutFailure extends Failure {}

//Connection failure
class ConnectionFailure extends Failure{}
