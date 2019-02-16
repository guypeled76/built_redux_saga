import 'package:redux_saga/redux_saga.dart';
import 'package:built_redux/built_redux.dart';
import 'actions.dart';
import 'state.dart';

main() async {

  Reducer<AppState, AppStateBuilder, dynamic> createAppReducer() {
    return (new ReducerBuilder<AppState, AppStateBuilder>()
    ).build();
  }


  Store<AppState, AppStateBuilder, AppActions> store = new Store(
      createAppReducer(), // build returns a reducer function
      new AppState(),
      new AppActions(),
      middleware:
      <Middleware<AppState, AppStateBuilder, AppActions>>[
        createSagaMiddleware<AppState, AppStateBuilder, AppActions>([]
          ..add(test())
          ..add(delayTest())
        ),
      ]
  );

  while(true) {
    await Future.delayed(Duration(seconds: 1));
    store.actions.test2("This is a test");
  }


}

Iterable<Runnable> delayTest() sync* {
  while (true) {
    Action<String> action;
    yield take(AppActionsNames.test2, (v) => action = v);

    print("taken ${action}");

    //while(true) {
    print("before delay test");
    yield delay(Duration(seconds: 1));
    print("after1 delay test");
    yield delay(Duration(seconds: 1));
    print("after2 delay test");
  }
}


Iterable<Runnable> test() sync* {
  Action<String> action;
  yield take(AppActionsNames.test2, (v) => action = v);
  print("in test");
  yield all([error1(test1(), "cp1"), error1(test2(), "cp2")]);
  print("out test");
}


Iterable<Runnable> error1(Iterable<Runnable> saga, String label) sync* {

  print("in error1");
  try {
    yield put("before ${label}");
    yield* saga;
    yield put("after ${label}");
  } catch(e) {
    yield put(e);
  }

  print("out error1");
}

Iterable<Runnable> test1() sync* {

  print("in test1");
  //while(true) {
    try {
      Action<String> action;
      yield take(AppActionsNames.test2, (v) => action = v);
      yield put(action);

      String v;
      yield call(getSomething(), (value) => v = value);
      yield put(v);
    } catch (e) {
      yield put(e);
    }
  //}

  print("out test1");
}

Iterable<Runnable> test2() sync* {

  print("in test2");
  yield take(AppActionsNames.test2);
  for(int i=0;i<4;i++) {
    yield put("iterator:${i}");
  }


  String ss;
  yield select("dd", (v) => ss = v);
  if(ss == null) {
    yield put(ss);
  }
  print("out test2");
}

Future<String> getSomething() {
  return Future.delayed(Duration(seconds: 2), () => "This is a delayed API response");
}
