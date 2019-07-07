import 'package:built_redux/built_redux.dart';
import 'package:built_redux_saga/built_redux_saga.dart';
import 'package:test/test.dart';
import 'state/actions.dart';
import 'state/state.dart';

void main() {
  group('A group of tests', () {



    setUp(() {

    });

    test('Store sanity test', () {
      Store<AppState, AppStateBuilder, AppActions> _store = createAppState([]);
      _store.actions.increment(3);
      assert(_store.state.count == 3, "Count should be 3.");

      _store.actions.increment(3);
      assert(_store.state.count == 6, "Count should be 6.");
    });

    test('Store middleware sanity test', () {

      Iterable<Runnable> jocker() sync* {
        while(true) {

          yield take(AppActionsNames.increment);

          yield put(AppActionsNames.increment, 1);
        }
      }

      Store<AppState, AppStateBuilder, AppActions> _store = createAppState([jocker()]);

      _store.actions.increment(3);
      assert(_store.state.count == 4, "Count should be 4.");

      _store.actions.increment(3);
      assert(_store.state.count == 7, "Count should be 7.");
    });

    test('Select/Register sanity test', () {

      Iterable<Runnable> registerSaga() sync* {
        yield register("test");

        String value;
        yield select<String>((result) {
          value = result;
        });

        if(value == "test") {
          yield put(AppActionsNames.increment, 10);
        }
      }

      Store<AppState, AppStateBuilder, AppActions> _store = createAppState([registerSaga()]);


      assert(_store.state.count == 10, "Count should be 10");
    });


    test('Fork sanity test', () {

      Iterable<Runnable> forkedProcess() sync* {
        while(true) {
          yield take(AppActionsNames.increment);
          yield put(AppActionsNames.increment, 3);
        }
      }

      Iterable<Runnable> testFork() sync* {

        yield fork(forkedProcess());

        while(true) {
          yield take(AppActionsNames.log);
          yield put(AppActionsNames.increment, 1);
        }

      }

      Store<AppState, AppStateBuilder, AppActions> _store = createAppState([testFork()]);

      _store.actions.increment(3);

      assert(_store.state.count == 6, "Count should be 6");

      _store.actions.log("test");

      assert(_store.state.count == 7, "Count should be 7");

      _store.actions.increment(3);

      assert(_store.state.count == 13, "Count should be 6");

      _store.actions.log("test");

      assert(_store.state.count == 14, "Count should be 7");

    });
  });
}
