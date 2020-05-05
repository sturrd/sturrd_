import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sturrd_flutter/core/presentation/bloc/navigator/bloc.dart';
import 'package:sturrd_flutter/features/login/domain/entities/user.dart';
// import 'package:sturrd_flutter/core/presentation/bloc/navigator/bloc.dart';

abstract class NavigationAction extends Equatable {
  @override
  List<Object> get props => [];
}
class NavigatorPopEvent extends NavigationAction{}

class NavigateToLoginScreenEvent extends NavigationAction{}

class NavigateFromSplashToHomeEvent extends NavigationAction{
  final User user;
  NavigateFromSplashToHomeEvent({@required this.user});
}

class LogoutNavigationEvent extends NavigationAction{}

class NavigateToSettingsEvent extends NavigationAction{
  NavigateToSettingsEvent();
}
