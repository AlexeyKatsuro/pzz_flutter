import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/domain/repository/pzz_repository.dart';
import 'package:pzz/models/app_state.dart';
import 'package:redux/redux.dart';

typedef MiddlewareTyped<State, Action> = dynamic Function(
  Store<State> store,
  Action action,
  NextDispatcher next,
);

List<Middleware<AppState>> createPzzMiddleware(PzzRepository repository) {
  return [
    TypedMiddleware<AppState, InitialAction>(_createInitial(repository)),
    TypedMiddleware<AppState, LoadPizzasAction>(_createLoadPizzas(repository)),
    TypedMiddleware<AppState, LoadBasketAction>(_createLoadBasket(repository)),
    TypedMiddleware<AppState, AddProductAction>(_createAddPizzaItem(repository)),
    TypedMiddleware<AppState, RemoveProductAction>(_createRemovePizzaItem(repository)),
  ];
}

Middleware<AppState> _createInitial(PzzRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(StartLoadingAction());
    try {
      final pizzas = repository.loadPizzas();
      final sauces = repository.loadSauces();
      store.dispatch(PizzasLoadedAction(await pizzas));
      store.dispatch(SaucesLoadedAction(await sauces));

      final basket = await repository.loadBasket();
      store.dispatch(BasketLoadedAction(basket));
    } catch (ex) {
      print(ex);
    }
    next(StopLoadingAction());
    next(action);
  };
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

MiddlewareTyped<AppState, AddProductAction> _createAddPizzaItem(PzzRepository repository) {
  return (Store<AppState> store, AddProductAction action, NextDispatcher next) {
    repository.addProductToBasket(action.product).then((basket) {
      store.dispatch(BasketLoadedAction(basket));
    }).catchError((ex) {
      print(ex);
    });
    next(action);
  };
}

MiddlewareTyped<AppState, RemoveProductAction> _createRemovePizzaItem(PzzRepository repository) {
  return (Store<AppState> store, RemoveProductAction action, NextDispatcher next) {
    repository.removeProductFromBasket(action.product).then((basket) {
      store.dispatch(BasketLoadedAction(basket));
    }).catchError((ex) {
      print(ex);
    });
    next(action);
  };
}
