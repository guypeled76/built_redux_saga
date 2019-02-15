import 'package:redux_saga/redux_saga.dart';
import 'dart:io';

main() async {


  SagaManager manager = SagaManager(test());


  print("run");
  while(true) {
    RunnableStatus status = manager.run();

    print("run:${status}");

    if(status != RunnableStatus.Done) {
      await Future.delayed(Duration(seconds: 1));
    } else {
      break;
    }
  }

  print("Done.");

}

Iterable<Runnable> test() sync* {
  print("in test");
  yield all([error1(test1()), test2()]);
  print("out test");
}


Iterable<Runnable> error1(Iterable<Runnable> saga) sync* {

  print("in error1");
  try {
    yield put("before code");
    yield* saga;
    yield put("after code");
  }
  catch(e) {
    yield put(e);
  }

  print("out error1");
}

Iterable<Runnable> test1() sync* {

  print("in test1");
  //while(true) {
    try {
      String action;
      yield take("test", (v) => action = v);
      yield put(action);
    } catch (e) {
      yield put(e);
    }
  //}

  print("out test1");
}

Iterable<Runnable> test2() sync* {

  print("in test2");
  yield take("test");
  for(int i=0;i<4;i++) {
    yield put("iterator:${i}");
  }
  String v;
  yield call(getSomething(), (value) => v = value);
  yield put(v);

  String ss;
  yield select("dd", (v) => ss = v);
  if(ss == null) {
    yield put(ss);
  }
  print("out test2");
}

Future<String> getSomething() {
  return Future.delayed(Duration(seconds: 2), () => "This is a test");
}
