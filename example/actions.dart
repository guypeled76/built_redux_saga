import 'package:built_redux/built_redux.dart';

part 'actions.g.dart';

abstract class AppActions extends ReduxActions {


  ActionDispatcher<String> initialize;
  ActionDispatcher<String> startTask;
  ActionDispatcher<String> endTask;
  ActionDispatcher<String> test;
  ActionDispatcher<Object> error;
  ActionDispatcher<String> log;





  AppActions._();
  factory AppActions() => new _$AppActions();
}