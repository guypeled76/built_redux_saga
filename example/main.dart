import 'package:redux_saga/redux_saga.dart';

main() {


  SagaManager manager = SagaManager();

  manager.run(test());

}

Iterable<Runnable> test() sync* {
  yield all([error1(test1()), test2()]);
}


Iterable<Runnable> error1(Iterable<Runnable> saga) sync* {

  try {
    yield put("before code");
    yield* saga;
    yield put("after code");
  }
  catch(e) {
    yield put(e);
  }
}

Iterable<Runnable> test1() sync* {

  try {
    String action;
    yield take("test", (v) => action = v);
    yield put(action);
  } catch(e) {
    yield put(e);
  }
}

Iterable<Runnable> test2() sync* {

  yield take("test");
  yield put("dd");
  String v;
  yield call(getSomething(), (value) => v = value);
  yield put(v);

  String ss;
  yield select("dd", (v) => ss = v);
  if(ss == null) {
    yield put(ss);
  }
}

Future<String> getSomething() {
  return Future.value("This is a test");
}
