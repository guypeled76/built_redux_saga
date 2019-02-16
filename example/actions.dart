import 'package:built_redux/built_redux.dart';

part 'actions.g.dart';

abstract class AppAction extends ReduxActions {


  ActionDispatcher<String> initialize;
  ActionDispatcher<String> test1;
  ActionDispatcher<String> test2;
  ActionDispatcher<String> test3;




  AppAction._();
  factory AppAction() => new _$AppAction();
}