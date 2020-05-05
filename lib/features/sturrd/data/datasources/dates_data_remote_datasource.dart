import 'package:sturrd_flutter/features/sturrd/domain/entities/dates_list.dart';
import 'package:sturrd_flutter/features/sturrd/domain/entities/dates_list_stream.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../../core/error/exceptions.dart';

enum Dates { ALL, THEIRS, YOURS, FIFTY_FIFTY }

abstract class DatesDataRemoteDataSource {
  ///
  ///
  ///
  Future<DatesList> getDatesFromDatabase(Dates label);

  ///
  ///
  ///
  Future<DatesListStream> getDatesStreamFromDatabase(Dates label);
}

class DatesDataRemoteDataSourceImpl implements DatesDataRemoteDataSource {
  Query requestsRef = FirebaseDatabase.instance.reference().child("Requests");

  @override
  Future<DatesList> getDatesFromDatabase(Dates label) async {
    try {
      //TODO
      // return DatesList(
      //     list: requestsRef.once());
    } on Exception {
      throw ServerException();
    }
  }

  @override
  Future<DatesListStream> getDatesStreamFromDatabase(Dates label) async {
    if (label == Dates.ALL) {
      requestsRef = FirebaseDatabase.instance
          .reference()
          .child("Requests")
          .orderByChild("timeStamp");
    } else if (label == Dates.YOURS) {
      requestsRef = FirebaseDatabase.instance
          .reference()
          .child("Requests")
          .orderByChild("treatTypeId")
          .equalTo(1);
    } else if (label == Dates.THEIRS) {
      requestsRef = FirebaseDatabase.instance
          .reference()
          .child("Requests")
          .orderByChild("treatTypeId")
          .equalTo(0);
    } else {
      //50-50
      FirebaseDatabase.instance
          .reference()
          .child("Requests")
          .orderByChild("treatTypeId")
          .equalTo(2);
    }
    try {
      return DatesListStream(list: requestsRef.onValue);
    } catch (e) {
      throw ServerException();
    }
  }
}
