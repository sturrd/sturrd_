import 'package:flutter/material.dart';

//we will deal with orientation in this file.

class SizeConfig{
  static double _screenWidth;
  static double _screenHeight;
  static double _blockSizeHorizontal=0;
  static double _blockSizeVertical = 0;

  static double textMultiplier;
  static double imageSizeMultiplier;
  static double heightMultiplier;
  static double widthMultiplier;
  static bool isPortrait = true;

  void init(BoxConstraints constraints,Orientation orientation){
    if(orientation == Orientation.portrait){
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
      isPortrait = true;
    }else{  //orientation = Orientation.landscape.
      _screenWidth = constraints.maxHeight;
      _screenHeight = constraints.minWidth;
      isPortrait = false;
    }
    _blockSizeHorizontal = _screenWidth / 100; 
    _blockSizeVertical = _screenHeight / 100;

    textMultiplier = _blockSizeVertical;
    imageSizeMultiplier = _blockSizeHorizontal;
    heightMultiplier =_blockSizeVertical;
    widthMultiplier = _blockSizeHorizontal;
  }

}




