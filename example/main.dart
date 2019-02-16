import 'package:redux_saga/redux_saga.dart';
import 'package:built_redux/built_redux.dart';
import 'actions.dart';

main() async {


  SagaManager manager = SagaManager([test(), delayTest()]);


  print("run");
  manager.run();

  while(true) {


    print("run:${manager.status}");

    if(manager.status != RunnableStatus.Done) {
      await Future.delayed(Duration(seconds: 1));
      manager.actions.add(Action(AppActionNames.test2.name, "ff"));
    } else {

      break;
    }
  }

  print("Done.");

}

Iterable<Runnable> delayTest() sync* {

  Action<String> action;
  yield take(AppActionNames.test2, (v) => action = v);
  //while(true) {
  print("before delay test");
  yield delay(Duration(seconds: 5));
  print("after1 delay test");
  yield delay(Duration(seconds: 5));
  print("after2 delay test");
  //}
}


Iterable<Runnable> test() sync* {
  Action<String> action;
  yield take(AppActionNames.test2, (v) => action = v);
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
      yield take(AppActionNames.test2, (v) => action = v);
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
  yield take(AppActionNames.test2);
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
