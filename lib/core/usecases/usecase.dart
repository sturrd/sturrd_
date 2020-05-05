import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sturrd_flutter/core/error/failures.dart';
import 'package:sturrd_flutter/features/sturrd/dates/data/datasources/dates_data_remote_datasource.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

class Params extends Equatable {
  //final int number;
  final GoogleSignIn googleSignIn;
  final FirebaseAuth auth;
  final Firestore firestore;

  final String path;
  final Dates label;

  Params({this.googleSignIn, this.auth, this.firestore,this.path,this.label});

  @override
  List<Object> get props => [googleSignIn,auth,firestore];
}
