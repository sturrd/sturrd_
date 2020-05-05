import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sturrd_flutter/core/presentation/bloc/navigator/bloc.dart';

class SplashPage extends StatefulWidget {
  static const id = 'Splash page route';
  const SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
     Future.delayed(Duration(milliseconds: 2500), () {
       BlocProvider.of<NavigatorBloc>(context).add(NavigateToLoginScreenEvent());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: RichText(
              text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: '      Sturrd \n',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 18,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    print('tapped');
                  },
              ),
              TextSpan(
                text: 'Go on Real dates',
                style: TextStyle(color: Colors.black),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
