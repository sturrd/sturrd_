import 'package:flutter/material.dart';

class DatesCard extends StatelessWidget {
   DatesCard({
    Key key,
    @required this.date,
    @required this.time,
    @required this.assetSrc,
  }) : super(key: key);

  final Map date;
   var time;
   var assetSrc;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(8.0))),
        margin: EdgeInsets.symmetric(
            vertical: 5.0, horizontal: 10.0),
        child:   Container(
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius:
                BorderRadius.all(Radius.circular(8.0)),
            backgroundBlendMode: BlendMode.darken,
            image: DecorationImage(
              image: NetworkImage(date["placeImageUrl"]),
              fit: BoxFit.cover,
            ),
          ),
          height: 100,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.all(
                    Radius.circular(8.0)),
                backgroundBlendMode: BlendMode.darken,
              )),
              Row(
                children: <Widget>[
                  Container(
                      margin:   EdgeInsets.all(10.0),
                      alignment: Alignment.center,
                      height: 60,
                      width: 60,
                      decoration:   BoxDecoration(
                          color: Colors.pink,
                          image:   DecorationImage(
                            image: NetworkImage(
                                date['profileImageUrl']),
                            fit: BoxFit.cover,
                          ),
                          borderRadius:   BorderRadius
                                  .all(
                               Radius.circular(50.0)),
                          border:   Border.all(
                            color: Colors.pink,
                            width: 2.0,
                          ))),
                  Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: <Widget>[
                       Text(
                          date['name'] +
                              ", " +
                              date['age'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white)),
                       Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: <Widget>[
                           Icon(
                            Icons.location_on,
                            color: Colors.pink,
                            size: 24.0,
                          ),
                           SizedBox(
                            width: 180,
                            child: Text(
                                date['place_name'] +
                                    " ,2km",
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                textAlign:
                                    TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight:
                                        FontWeight.normal,
                                    fontSize: 16)),
                          ),
                          // SizedBox(
                          //   width: 15.0,
                          // ),
                        ],
                      ),
                       Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: <Widget>[
                           Icon(
                            Icons.calendar_today,
                            color: Colors.pink,
                            size: 24.0,
                          ),
                           Text(time,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight:
                                      FontWeight.normal,
                                  fontSize: 16)),
                           SizedBox(
                            width: 15.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Image.asset(
                    assetSrc,
                    color: Colors.pink,
                    width: 48,
                    height: 48,
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
