import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  static const String id = 'Settings Page route';
  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('Settings Page'),
        ),
      ),
    );
  }
}
