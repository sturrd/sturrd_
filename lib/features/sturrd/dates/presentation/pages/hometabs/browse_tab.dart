import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sturrd_flutter/core/constants/images.dart';
import 'package:sturrd_flutter/features/sturrd/dates/data/datasources/dates_data_remote_datasource.dart';
import 'package:sturrd_flutter/features/sturrd/dates/presentation/bloc/dates_bloc/dates_bloc.dart';
import 'package:sturrd_flutter/features/sturrd/dates/presentation/bloc/dates_bloc/dates_event.dart';
import 'package:sturrd_flutter/features/sturrd/dates/presentation/bloc/dates_bloc/dates_state.dart';
import 'package:sturrd_flutter/features/sturrd/dates/presentation/widgets/dates_card.dart';

class Browse extends StatefulWidget {
  static const id = 'Browse Page route';
  const Browse({
    Key key,
  }) : super(key: key);

  @override
  _BrowseState createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  int selectedIndex = 0;
  List<Map<dynamic, dynamic>> requestList = [];


  @override
  void initState() {
    super.initState();
    BlocProvider.of<DatesBloc>(context)
        .add(GetDatesListStreamFromDatabase(Dates.ALL));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> wrapChildren = [
      FilterChip(
        label: Text('All'),
        selected: selectedIndex == 0,
        onSelected: (bool selected) {
          //bad practice - Ill be back
          setState(() {
            selectedIndex = 0;
          });
          BlocProvider.of<DatesBloc>(context)
              .add(GetDatesListStreamFromDatabase(Dates.ALL));
        },
        checkmarkColor: Colors.black,
      ),
      SizedBox(
        width: 10,
      ),
      FilterChip(
        label: Text('Theirs'),
        selected: selectedIndex == 1,
        onSelected: (bool selected) {
          setState(() {
            selectedIndex = 1;
          });
          BlocProvider.of<DatesBloc>(context)
              .add(GetDatesListStreamFromDatabase(Dates.THEIRS));
        },
      ),
      SizedBox(
        width: 10,
      ),
      FilterChip(
        label: Text('Yours'),
        selected: selectedIndex == 2,
        onSelected: (bool selected) {
          setState(() {
            selectedIndex = 2;
          });
          BlocProvider.of<DatesBloc>(context)
              .add(GetDatesListStreamFromDatabase(Dates.YOURS));
        },
      ),
      SizedBox(
        width: 10,
      ),
      FilterChip(
          label: Text('50/50'),
          selected: selectedIndex == 3,
          onSelected: (bool selected) {
            setState(() {
              selectedIndex = 3;
            });
            BlocProvider.of<DatesBloc>(context)
                .add(GetDatesListStreamFromDatabase(Dates.FIFTY_FIFTY));
          }),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Text("Dates Nearby",
                style: TextStyle(
                    fontSize: 21,
                    color: Colors.pink,
                    fontStyle: FontStyle.normal)),
            new Container(
              margin: new EdgeInsets.only(bottom: 20.0),
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: new Text(
                  //TODO GET DATE LENGTH AND REPLACE.
                  19.toString(),
                  style: new TextStyle(fontSize: 12.0),
                ),
              ),
              decoration:
                  new BoxDecoration(color: Colors.pink, shape: BoxShape.circle),
            )
          ],
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          Wrap(children: wrapChildren),
          Container(
            child: Expanded(
              child: BlocBuilder<DatesBloc, DatesState>(
                  builder: (BuildContext context, DatesState state) {
                if (state is DatesInitializing) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is DatesInitialized) {
                  return DatesInitializedWidget(requestList: requestList,state:state);
                } else if (state is ErrorDatesState) {
                  return Center(child: Text('Error'));
                }
                return Container(
                  child: Center(
                    child: Text('Unimplemented state'),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class DatesInitializedWidget extends StatelessWidget {
  var state;
   DatesInitializedWidget({
    Key key,this.state,
    @required this.requestList,
  }) : super(key: key);

  final List<Map> requestList;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: state.datesListStream.list,
      builder: (BuildContext context, AsyncSnapshot<Event> event){
        requestList.clear();
        if (event.hasData) {
          Map<dynamic, dynamic> values =
              event.data.snapshot.value;
          if (values != null)
            values.forEach((key, value) {
              print(value);
              requestList.add(value);
            });
        }
          return ListView.builder(
          itemCount: requestList.length,
          itemBuilder: (BuildContext context, int index) {
            var date = requestList[index];
            var time;
            var assetSrc;
            var hour;

            //TODO : Remove following logic.
            hour = int.parse(date['hour'].toString());
            if (hour > 12) {
              hour -= 12;
              time = date['dateFormat'] +
                  " at " +
                  hour.toString() +
                  ":" +
                  date['minutes'] +
                  " pm";
            } else if (hour == 0) {
              hour += 12;
              time = date['dateFormat'] +
                  " at " +
                  hour.toString() +
                  ":" +
                  date['minutes'] +
                  " am";
            } else if (hour < 12) {
              time = date['dateFormat'] +
                  " at " +
                  hour.toString() +
                  ":" +
                  date['minutes'] +
                  " am";
            }

            if (int.parse(date['place_type'].toString()) == 0) {
              assetSrc = Images.restaurant;
            } else if (int.parse(date['place_type'].toString()) ==
                1) {
              assetSrc = Images.cinema;
            } else if (int.parse(date['place_type'].toString()) ==
                2) {
              assetSrc = Images.club;
            } else if (int.parse(date['place_type'].toString()) ==
                3) {
              assetSrc = Images.cinema;
            }
            return DatesCard(date: date, time: time, assetSrc: assetSrc);
          },
        );
      },
    );
  }
}

