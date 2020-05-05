import 'package:equatable/equatable.dart';
import 'package:sturrd_flutter/features/login/domain/entities/user.dart';
import 'package:meta/meta.dart';

abstract class LoginState extends Equatable {
 @override
  List<Object> get props => [];}

class InitialLoginState extends LoginState {}

class AuthenticatingLoginState extends LoginState{}

class AuthenticatedLoginState extends LoginState{
  final User loggedInUser;

  AuthenticatedLoginState({@required this.loggedInUser});

}

class ErrorLoginState extends LoginState{
   final String message;

  ErrorLoginState({@required this.message});

   @override
  List<Object> get props => [message];
}