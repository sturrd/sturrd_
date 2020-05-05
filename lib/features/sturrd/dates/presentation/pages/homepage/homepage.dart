import 'package:flutter/material.dart';

import '../../bloc/browse_bloc/browse_bloc.dart';
import '../hometabs/browse_tab.dart';
import '../hometabs/home_tab.dart';

class HomePage extends StatefulWidget {
  static const id = 'HomePage id';
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageStorageBucket bucket = PageStorageBucket();

  final List<Widget> pages = [
    Browse(),
    Home(),
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
   // final screenwidth = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        Scaffold(
          body: StreamBuilder<Widget>(
              stream: browseBloc.currentScreen,
              builder: (context, snapshot) {
                return PageStorage(
                  bucket: bucket,
                  child: snapshot.data ?? Container(),
                );
              }),
          bottomNavigationBar: BottomAppBar(
            elevation: 0.0,
            shape: CircularNotchedRectangle(),
            child: Container(
              height: screenHeight / 12,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [SizedBox(width: 50), ...bottomNavBarItems],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 30,
          bottom: 20,
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.pinkAccent,
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  List<Widget> bottomNavBarItems = [
    StreamBuilder<int>(
        stream: browseBloc.tabIndex,
        initialData: 0,
        builder: (context, snapshot) {
          return MaterialButton(
            minWidth: 40,
            onPressed: () {
              browseBloc.addScreen(Browse());
              browseBloc.addTabIndex(0);
            },
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.search,
                  color: snapshot.data == 0 ? Colors.pinkAccent : Colors.grey,
                ),
                Text(
                  'Browse',
                  style: TextStyle(
                    color: snapshot.data == 0 ? Colors.pinkAccent : Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }),
    StreamBuilder<int>(
        stream: browseBloc.tabIndex,
        initialData: 0,
        builder: (context, snapshot) {
          return MaterialButton(
            minWidth: 40,
            onPressed: () {
              browseBloc.addScreen(Home());
              browseBloc.addTabIndex(1);
            },
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.home,
                  color: snapshot.data == 1 ? Colors.pinkAccent : Colors.grey,
                ),
                Text(
                  'Home',
                  style: TextStyle(
                    color: snapshot.data == 1 ? Colors.pinkAccent : Colors.grey,
                  ),
                ),
              ],
            ),
          );
        })
  ];
}



