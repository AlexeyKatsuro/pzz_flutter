import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/domain/repository/pzz_repository.dart';
import 'package:pzz/models/app_state.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createPzzMiddleware(PzzRepository repository) {
  return [
    TypedMiddleware<AppState, LoadPizzasAction>(_createLoadPizzas(repository)),
    TypedMiddleware<AppState, LoadBasketAction>(_createLoadBasket(repository)),
    TypedMiddleware<AppState, InitialAction>(_createInitial(repository)),
    TypedMiddleware<AppState, AddPizzaAction>(_createAddPizzaItem(repository)),
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

Middleware<AppState> _createLoadBasket(PzzRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    repository.loadBasket().then((basket) {
      store.dispatch(BasketLoadedAction(basket));
    }).catchError((ex) {
      print(ex);
    });

    next(action);
  };
}

Middleware<AppState> _createInitial(PzzRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    try {
      final pizzas = await repository.loadPizzas();
      store.dispatch(PizzasLoadedAction(pizzas));
      final basket = await repository.loadBasket();
      store.dispatch(BasketLoadedAction(basket));
    } catch (ex) {
      print(ex);
    }
    next(action);
  };
}

Middleware<AppState> _createAddPizzaItem(PzzRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is AddPizzaAction) {
      print('------------action is AddPizzaAction');
      repository.addPizzaItem(action.pizza, action.size).then((basket) {
        print('-----addPizzaItem');
        store.dispatch(BasketLoadedAction(basket));
      }).catchError((ex) {
        print(ex);
      });
    }
    next(action);
  };
}
