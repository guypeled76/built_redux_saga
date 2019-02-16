import 'package:built_redux/built_redux.dart';

part 'actions.g.dart';

abstract class AppActions extends ReduxActions {


  ActionDispatcher<String> initialize;
  ActionDispatcher<String> test1;
  ActionDispatcher<String> test2;
  ActionDispatcher<String> test3;




  AppActions._();
  factory AppActions() => new _$AppActions();
}