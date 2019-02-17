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
  final ActionDispatcher<String> startTask =
      new ActionDispatcher<String>('AppActions-startTask');
  final ActionDispatcher<String> endTask =
      new ActionDispatcher<String>('AppActions-endTask');
  final ActionDispatcher<String> test =
      new ActionDispatcher<String>('AppActions-test');
  final ActionDispatcher<Object> error =
      new ActionDispatcher<Object>('AppActions-error');
  final ActionDispatcher<String> log =
      new ActionDispatcher<String>('AppActions-log');

  @override
  void setDispatcher(Dispatcher dispatcher) {
    initialize.setDispatcher(dispatcher);
    startTask.setDispatcher(dispatcher);
    endTask.setDispatcher(dispatcher);
    test.setDispatcher(dispatcher);
    error.setDispatcher(dispatcher);
    log.setDispatcher(dispatcher);
  }
}

class AppActionsNames {
  static final ActionName<String> initialize =
      new ActionName<String>('AppActions-initialize');
  static final ActionName<String> startTask =
      new ActionName<String>('AppActions-startTask');
  static final ActionName<String> endTask =
      new ActionName<String>('AppActions-endTask');
  static final ActionName<String> test =
      new ActionName<String>('AppActions-test');
  static final ActionName<Object> error =
      new ActionName<Object>('AppActions-error');
  static final ActionName<String> log =
      new ActionName<String>('AppActions-log');
}
