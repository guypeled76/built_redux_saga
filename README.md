## Built Redux Saga implementation. 

Provides support for handling middleware effects using sagas. 

From Author:

I am working on this library as of a flutter/angular dart project that I am working on.
I created a common library that both the flutter project and the angular dart project is using, which
is based on built redux for managing state and RxDart for propagating the state to the UI components 
via BLoC pattern. When I got to writing the middleware I was not satisfied with the 
readability and maintainability of the epics concept and I the built_redux_rx implementation 
as the code was very bulky and did not gave the business logic an easy way to stand out.

The concept of long lasting transactions that is saga for me is a better fit for managing the
business logic part or in redux terms the middleware. Sagas are compose-able and really give the 
business logic the ability to standout from a short glimpse. It is less bulky in my opinion
than the epic middleware and more powerful than the thunk concept.

I have tried to maintain compatibility with the redux-saga-js library but I am still in the 
process of checking how it migrates to dart. JavaScript has a feature of expression yields which
allows to yield the execution at the expression level and not only at the statement level.
This is a very hard limitation on the dart side that forced me to use callbacks instead 
of having simple effects that return results.

The implementation is rather simple and I plan to simplify it even more as I go. 
I will soon add documentations to the saga effects I have created.

I have added a concept of saga registry which can be utilized using the select effect and the
register effect. select allows you to select a registered entity like the State, and register allows you to
register and entity by it's type. I have used it to provide quick access to platform specific 
services in my flutter/angular project. I have a common service base types that are implemented
differently by the flutter project and the angular dart project which are registered on the base types.
That way the saga middle ware can work agnostic to the platform it is running on.

## Usage

A simple usage example:

```dart
import 'package:built_redux_saga/built_redux_saga.dart';
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
          ..add(testSaga())
          ..add(delaySaga())
          ..add(logSaga())
        ),
      ]
  );

  while(true) {
    await Future.delayed(Duration(seconds: 1));
    store.actions.test("This is a test");
  }


}

Iterable<Runnable> logSaga() sync* {
  while (true) {
    Action<String> action;
    yield takeEverything(ResultHandler((result) {
      action = result;
    }));
    print("log ${action}");
  }
}
Iterable<Runnable> delaySaga() sync* {
  while (true) {
    Result<String> result = Result();
    yield take(AppActionsNames.test, result);
    print("taken ${result.value}");

    print("before delay test");
    yield delay(Duration(seconds: 1));
    print("after1 delay test");
    yield delay(Duration(seconds: 1));
    print("after2 delay test");
  }
}


Iterable<Runnable> testSaga() sync* {
  Result<Action<String>> result = Result();
  yield take(AppActionsNames.test, result);
  print("in test taken ${result.value}");
  
  yield all([reportedSaga(test1(), "test1 task"), reportedSaga(test2(), "test2 task")]);
  
  print("out test");
}


Iterable<Runnable> reportedSaga(Iterable<Runnable> saga, String label) sync* {

  print("start reported task ${label}");
  try {
    yield put(AppActionsNames.startTask, "before ${label}");
    yield* saga;
    yield put(AppActionsNames.endTask, "after ${label}");
  } catch(e) {
    yield put(AppActionsNames.error, e);
  }

  print("end reported task ${label}");
}

Iterable<Runnable> test1() sync* {

  print("entering test1");

    try {
      Action<String> action;
      yield take(AppActionsNames.test, ResultHandler((result) { 
        action = result;
      }));
      yield put(AppActionsNames.log, "dispatching: ${action}");

      String value;
      yield call(getSomething(), ResultHandler((result) {
        value = result;
      }, (error) {
        // handle error
      }));
      yield put(AppActionsNames.log, "value: ${value}");
    } catch (e) {
      yield put(AppActionsNames.error, e);
    }


  print("exiting test1");
}

Iterable<Runnable> test2() sync* {

  print("entering test2");
  yield take(AppActionsNames.test);
  for(int i=0;i<4;i++) {
    yield put(AppActionsNames.log, "from_iterator:${i}");
  }


  AppState state;
  yield select<AppState>(ResultHandler((result) {
    state = result;
  }));
  if(state != null) {
    yield put(AppActionsNames.log, "state: ${state}");
  }
  print("exiting test2");
}

Future<String> getSomething() {
  return Future.delayed(Duration(seconds: 2), () => "This is a delayed API response");
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/guypeled76/built_redux_saga/issues
