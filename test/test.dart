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
          Action<int> incAction;
          yield take(AppActionsNames.increment, (result) {
            incAction = result;
          });

          yield put(AppActionsNames.increment, 1);
        }
      }

      Store<AppState, AppStateBuilder, AppActions> _store = createAppState([jocker()]);

      _store.actions.increment(3);
      assert(_store.state.count == 4, "Count should be 4.");

      _store.actions.increment(3);
      assert(_store.state.count == 7, "Count should be 7.");
    });
  });
}
