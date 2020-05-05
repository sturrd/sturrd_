import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  final FirebaseUser user;
 

  User({
    @required this.user,
  });

  @override
  List<Object> get props => [user];
}
