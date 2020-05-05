import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sturrd_flutter/features/sturrd/dates/presentation/pages/hometabs/browse_tab.dart';


class BrowseBloc{
  //controller for currentScreen
  final _currentScreenController = BehaviorSubject<Widget>();

  //controller for animatedcontainer selectedIndex
  final _selectedIndexController = BehaviorSubject<int>();

  //controller for bottom tab
  final _tabIndexController = BehaviorSubject<int>();

  BrowseBloc(){
    addScreen(Browse());
    addIndex(0);
    addTabIndex(0);
    print(currentScreen);
    print(currentIndex);
  }
//sink
Function(Widget) get addScreen => _currentScreenController.sink.add;
Function(int) get addIndex => _selectedIndexController.sink.add;
Function(int) get addTabIndex => _tabIndexController.sink.add;


//stream
Stream<Widget>get currentScreen => _currentScreenController.stream;
Stream<int> get currentIndex => _selectedIndexController.stream; 
Stream<int> get tabIndex => _tabIndexController.stream; 


  dispose(){
    _currentScreenController.close();
    _selectedIndexController.close();
    _tabIndexController.close();
  }

}
final browseBloc = BrowseBloc();