import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sturrd_flutter/core/presentation/bloc/navigator/bloc.dart';
import 'package:sturrd_flutter/features/sturrd/presentation/bloc/gender_bloc/gender_bloc.dart';
import 'package:sturrd_flutter/features/sturrd/presentation/widgets/CustomButton.dart';

class SelectGenderPage extends StatelessWidget {
  static const id = 'SelectGenderPage';
  const SelectGenderPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(flex: 1, child: SizedBox()),
            Text(
              'Male',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10),
            GenderButton(
              gender: Gender.MALE,
            ),
            Expanded(flex: 2, child: SizedBox()),
            Text(
              'Female',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10),
            GenderButton(
              gender: Gender.FEMALE,
            ),
            Expanded(flex: 1, child: SizedBox()),
            CustomButton(
              text: 'Continue',
              onPressed: () {
                BlocProvider.of<NavigatorBloc>(context).add(NavigateFromSplashToHomeEvent(user:null));
              },
            ),
            Expanded(flex: 1, child: SizedBox()),
          ],
        ),
      )),
    );
  }
}

enum Gender { MALE, FEMALE }

class GenderButton extends StatelessWidget {
  final Gender gender;
  GenderButton({Key key, this.gender}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return  StreamBuilder<Gender>(
        stream: genderBloc.genderStream,
        builder: (BuildContext context, AsyncSnapshot<Gender> snapshot) {
          return Material(
            color: Colors.transparent,
            elevation: 0.0,
            child: GestureDetector(
              onTap: () {
                genderBloc.setGender(gender);

              },
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(80)),
                    color:
                        (gender == snapshot.data) ? Colors.red : Colors.white),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(
                    (gender == Gender.MALE)
                        ? FontAwesomeIcons.mars
                        : FontAwesomeIcons.venus,
                    color:
                        (gender == snapshot.data) ? Colors.white : Colors.red,
                  ),
                ),
              ),
            ),
          );
        });
  }
}
