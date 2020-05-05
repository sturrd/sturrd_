import 'package:rxdart/rxdart.dart';
import 'package:sturrd_flutter/features/sturrd/presentation/pages/select_gender_page.dart';

class GenderBloc{
final _controller = BehaviorSubject<Gender>();

//stream
 get genderStream => _controller.stream;

//sink 
Function(Gender)  get setGender => _controller.sink.add;

dispose(){
  _controller.close();
}


}
final genderBloc = GenderBloc();