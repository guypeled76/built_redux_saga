import 'package:built_redux/built_redux.dart';

part 'actions.g.dart';

abstract class AppActions extends ReduxActions {

  ActionDispatcher<String> log;


  ActionDispatcher<int> increment;
  ActionDispatcher<int> decrement;



  AppActions._();
  factory AppActions() => new _$AppActions();
}