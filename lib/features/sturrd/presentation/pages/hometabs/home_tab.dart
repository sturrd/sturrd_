//TODO : Rename and refactor.

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sturrd_flutter/core/constants/images.dart';
import 'package:sturrd_flutter/core/presentation/widgets/rounded_image_widget.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int connects = 15;
    return Column(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: SizedBox(),
        ),
        Expanded(
          flex: 14,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: SizedBox(),
                        ),
                        Expanded(
                          flex:5,
                          child: Center(
                            child: RoundedImageWidget(
                              isOnline: true,
                              imagePath: Images.dummy_profile_pic,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: SizedBox(),
                        ),
                        Expanded(
                          flex:3,
                          child: IconButton(
                            icon: Icon(FontAwesomeIcons.bell),
                            onPressed: () {
                              Fluttertoast.showToast(
                                  msg: "Implement the notifications feat");
                            },
                          ),
                        ),
                      ],
                    ),
                    RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(text: 'Lola, '),
                        TextSpan(text: '23 \n'),
                        TextSpan(text: 'Model')
                      ]),
                    ),
                    Text('You have $connects connects left!'),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Text('My Request'),
                  SizedBox(height: 25),
                  Text('You have posted no request'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
