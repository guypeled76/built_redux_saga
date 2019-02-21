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

  final ActionDispatcher<String> log =
      new ActionDispatcher<String>('AppActions-log');
  final ActionDispatcher<int> increment =
      new ActionDispatcher<int>('AppActions-increment');
  final ActionDispatcher<int> decrement =
      new ActionDispatcher<int>('AppActions-decrement');

  @override
  void setDispatcher(Dispatcher dispatcher) {
    log.setDispatcher(dispatcher);
    increment.setDispatcher(dispatcher);
    decrement.setDispatcher(dispatcher);
  }
}

class AppActionsNames {
  static final ActionName<String> log =
      new ActionName<String>('AppActions-log');
  static final ActionName<int> increment =
      new ActionName<int>('AppActions-increment');
  static final ActionName<int> decrement =
      new ActionName<int>('AppActions-decrement');
}
