import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/domain/repository/pzz_repository.dart';
import 'package:pzz/models/app_state.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createPzzMiddleware(PzzRepository repository) {
  return [
    TypedMiddleware<AppState, LoadPizzasAction>(_createLoadPizzas(repository)),
  ];
}

Middleware<AppState> _createLoadPizzas(PzzRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    repository.loadPizzas().then((pizzas) {
      store.dispatch(PizzasLoadedAction(pizzas));
    }).catchError((ex) {
      print(ex);
    });

    next(action);
  };
}
