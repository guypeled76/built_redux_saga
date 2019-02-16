// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actions.dart';

// **************************************************************************
// BuiltReduxGenerator
// **************************************************************************

// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: annotate_overrides

class _$AppActions extends AppActions {
  factory _$AppActions() => new _$AppActions._();
  _$AppActions._() : super._();

  final ActionDispatcher<String> initialize =
      new ActionDispatcher<String>('AppActions-initialize');
  final ActionDispatcher<String> test1 =
      new ActionDispatcher<String>('AppActions-test1');
  final ActionDispatcher<String> test2 =
      new ActionDispatcher<String>('AppActions-test2');
  final ActionDispatcher<String> test3 =
      new ActionDispatcher<String>('AppActions-test3');

  @override
  void setDispatcher(Dispatcher dispatcher) {
    initialize.setDispatcher(dispatcher);
    test1.setDispatcher(dispatcher);
    test2.setDispatcher(dispatcher);
    test3.setDispatcher(dispatcher);
  }
}

class AppActionsNames {
  static final ActionName<String> initialize =
      new ActionName<String>('AppActions-initialize');
  static final ActionName<String> test1 =
      new ActionName<String>('AppActions-test1');
  static final ActionName<String> test2 =
      new ActionName<String>('AppActions-test2');
  static final ActionName<String> test3 =
      new ActionName<String>('AppActions-test3');
}
