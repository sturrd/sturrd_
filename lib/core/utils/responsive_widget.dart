import 'package:flutter/material.dart';
import 'utils.dart';

class ResponsiveWidget extends StatelessWidget {
   ResponsiveWidget({Key key, @required this.portraitLayout,this.landscapeLayout}) : super(key: key);

   final Widget portraitLayout;
   final Widget landscapeLayout;


  @override
  Widget build(BuildContext context) {
    if(SizeConfig.isPortrait){
      return portraitLayout;
    }else{
      return landscapeLayout ?? portraitLayout;
    }
  }
}