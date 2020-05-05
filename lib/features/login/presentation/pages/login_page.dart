import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sturrd_flutter/core/presentation/bloc/navigator/bloc.dart';
import 'package:sturrd_flutter/features/login/domain/entities/user.dart';
import 'package:sturrd_flutter/features/login/presentation/bloc/bloc.dart';

class LoginPage extends StatelessWidget {
  static const id = 'Login Page route';
  LoginPage({Key key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Sturrd'),
      ),
      body: BlocBuilder<LoginBloc, LoginState>(
          builder: (BuildContext context, LoginState state) {
        if (state is InitialLoginState) {
          return LoginWidget();
        } else if (state is AuthenticatingLoginState) {
          return LoginWidget();
        } else if (state is AuthenticatedLoginState) {
          return LoginWidget();
        } else if (state is ErrorLoginState) {
          return LoginWidget();
        } else {
          return throw UnimplementedError();
        }
      }), //LoginWidget(),
    );
  }
}

class LoginWidget extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldKey;
  LoginWidget({
    Key key,
    this.scaffoldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    handleError(PlatformException error) {
      print(error);
      switch (error.code) {
        case 'ERROR_INVALID_VERIFICATION_CODE':
          FocusScope.of(context).requestFocus(FocusNode());
          loginInputBloc.addErrorMessage('Invalid Code');
          Navigator.of(context).pop();
          break;
        default:
          loginInputBloc.addErrorMessage(error.message);
          break;
      }
    }

    signIn() async {
      try {
        final AuthCredential credential = PhoneAuthProvider.getCredential(
          verificationId: loginInputBloc.verificationId,
          smsCode: loginInputBloc.smsOTP,
        );
        final FirebaseUser user =
            (await FirebaseAuth.instance.signInWithCredential(credential)).user;
        final FirebaseUser currentUser =
            await FirebaseAuth.instance.currentUser();
        assert(user.uid == currentUser.uid);
        Navigator.of(context).pop();
        //!ERROR
        Navigator.of(context).pushReplacementNamed('/homepage');
      } catch (e) {
        handleError(e);
      }
    }

    if (loginInputBloc.showSMSOTP == true) {
      Future.delayed(Duration(milliseconds: 200), () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Enter SMS Code'),
                content: Container(
                  height: 85,
                  child: Column(children: [
                    TextField(onChanged: loginInputBloc.addsmsOTP),
                    (loginInputBloc.errorMessage != null
                        ? Text(
                            loginInputBloc.errorMessage,
                            style: TextStyle(color: Colors.red),
                          )
                        : Container())
                  ]),
                ),
                contentPadding: EdgeInsets.all(10),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Done'),
                    onPressed: () {
                      FirebaseAuth.instance.currentUser().then((user) {
                        if (user != null) {
                          Navigator.of(context).pop();
                          BlocProvider.of<NavigatorBloc>(context).add(
                              NavigateFromSplashToHomeEvent(
                                  user: User(user: user)));
                        } else {
                          signIn();
                        }
                      });
                    },
                  )
                ],
              );
            });
      });
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Enter Phone Number Eg. +910000000000'),
              onChanged: loginInputBloc.addPhoneNumber,
            ),
          ),
          (loginInputBloc.errorMessage != null
              ? Text(
                  loginInputBloc.errorMessage,
                  style: TextStyle(color: Colors.red),
                )
              : Container()),
          SizedBox(
            height: 10,
          ),
          RaisedButton(
            onPressed: () {
              BlocProvider.of<LoginBloc>(context).add(VerifyPhoneNumberEvent());
            },
            child: Text('Verify'),
            textColor: Colors.white,
            elevation: 7,
            color: Colors.blue,
          )
        ],
      ),
    );
  }
}
