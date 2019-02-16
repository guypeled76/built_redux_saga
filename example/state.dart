import 'package:built_value/built_value.dart';



part 'state.g.dart';


abstract class AppState implements Built<AppState, AppStateBuilder> {

  @nullable
  int get count;


  AppState._();
  factory AppState([updates(AppStateBuilder b)]) => new _$AppState((AppStateBuilder b) => b);

}