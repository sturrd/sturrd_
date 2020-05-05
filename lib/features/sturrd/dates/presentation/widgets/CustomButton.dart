import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key key, this.text, @required this.onPressed})
      : super(key: key);
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 6.0,
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: onPressed,
      constraints: BoxConstraints.tightFor(
        width: 200,
        height: 50.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      fillColor: Colors.redAccent,
    );
  }
}
