import 'package:built_redux/built_redux.dart';
import 'package:built_value/built_value.dart';
import 'package:built_redux_saga/built_redux_saga.dart';
import 'actions.dart';


part 'state.g.dart';


abstract class AppState implements Built<AppState, AppStateBuilder> {

  @nullable
  int get count;


  AppState._();
  factory AppState([updates(AppStateBuilder b)]) => new _$AppState((AppStateBuilder b) => b);

}

Store<AppState, AppStateBuilder, AppActions> createAppState(List<Iterable<Runnable>> runnableList) {
  Reducer<AppState, AppStateBuilder, dynamic> createAppReducer() {
    return (new ReducerBuilder<AppState, AppStateBuilder>()
        ..add(AppActionsNames.decrement, (state, action, builder) {
          builder.count =  (state.count == null ? 0 : state.count) - action.payload;
        })
      ..add(AppActionsNames.increment, (state, action, builder) {
        builder.count =  (state.count == null ? 0 : state.count) + action.payload;
      })
    ).build();
  }


  return new Store(
      createAppReducer(), // build returns a reducer function
      new AppState(),
      new AppActions(),
      middleware:
      <Middleware<AppState, AppStateBuilder, AppActions>>[
        createSagaMiddleware<AppState, AppStateBuilder, AppActions>(
            runnableList
        ),
      ]
  );
}