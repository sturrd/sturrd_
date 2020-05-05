import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sturrd_flutter/features/login/presentation/pages/login_page.dart';
import 'package:sturrd_flutter/features/settings/presentation/pages/settings_page.dart';
import 'package:sturrd_flutter/features/sturrd/dates/presentation/pages/homepage/homepage.dart';

import 'bloc.dart';

class NavigatorBloc extends Bloc<NavigationAction, dynamic>{
  
  final GlobalKey<NavigatorState> navigatorKey;
  NavigatorBloc({this.navigatorKey});

  @override
  dynamic get initialState => 0;

  @override
  Stream<dynamic> mapEventToState(NavigationAction event) async*{
    if(event is NavigatorPopEvent){
      navigatorKey.currentState.pop();     
    }else if(event is NavigateToLoginScreenEvent){
    navigatorKey.currentState.pushNamed(LoginPage.id); 
    }else if(event is LogoutNavigationEvent){
    }else if(event is NavigateToSettingsEvent){
      navigatorKey.currentState.pushNamed(SettingsPage.id);
    }else if (event is NavigateFromSplashToHomeEvent){
       navigatorKey.currentState.pushReplacementNamed(HomePage.id,arguments: {event.user});
    }
  }
}