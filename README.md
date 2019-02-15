A library for Dart developers.

Created from templates made available by Stagehand under a BSD-style
[license](https://github.com/dart-lang/stagehand/blob/master/LICENSE).

## Usage

A simple usage example:

```dart
import 'package:redux_saga/redux_saga.dart';
import 'dart:io';

main() async {


  SagaManager manager = SagaManager([test(), delayTest()]);


  print("run");
  manager.run();

  while(true) {


    print("run:${manager.status}");

    if(manager.status != RunnableStatus.Done) {
      await Future.delayed(Duration(seconds: 1));
    } else {
      break;
    }
  }

  print("Done.");

}

Iterable<Runnable> delayTest() sync* {
  //while(true) {
  print("before delay test");
  yield delay(Duration(seconds: 5));
  print("after1 delay test");
  yield delay(Duration(seconds: 5));
  print("after2 delay test");
  //}
}


Iterable<Runnable> test() sync* {
  print("in test");
  yield fork([error1(test1(), "cp1"), error1(test2(), "cp2")]);
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
      String action;
      yield take("test", (v) => action = v);
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
  yield take("test");
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
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: http://example.com/issues/replaceme
