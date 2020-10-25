import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/domain/person_info_form/actions/person_info_form_actions.dart';
import 'package:pzz/domain/repository/preference_repository.dart';
import 'package:pzz/domain/repository/pzz_repository.dart';
import 'package:pzz/domain/selectors/selector.dart';
import 'package:pzz/models/app_state.dart';
import 'package:redux/redux.dart';

typedef MiddlewareTyped<State, Action> = dynamic Function(
  Store<State> store,
  Action action,
  NextDispatcher next,
);

List<Middleware<AppState>> createPzzMiddleware(
  PzzRepository pzzRepository,
  PreferenceRepository preferenceRepository,
) {
  return [
    TypedMiddleware<AppState, InitialAction>(_createInitial(pzzRepository, preferenceRepository)),
    TypedMiddleware<AppState, LoadPizzasAction>(_createLoadPizzas(pzzRepository)),
    TypedMiddleware<AppState, LoadBasketAction>(_createLoadBasket(pzzRepository)),
    TypedMiddleware<AppState, AddProductAction>(_createAddPizzaItem(pzzRepository)),
    TypedMiddleware<AppState, RemoveProductAction>(_createRemovePizzaItem(pzzRepository)),
    TypedMiddleware<AppState, SavePersonalInfoAction>(_createSavePersonalInfo(preferenceRepository)),
    TypedMiddleware<AppState, SelectStreetAction>(_createSelectStreet(pzzRepository, preferenceRepository)),
    TypedMiddleware<AppState, SelectHouseAction>(_createSelectHouse(preferenceRepository)),
    TypedMiddleware<AppState, TryPlaceOrderAction>(_createUpdateAddress(pzzRepository)),
    TypedMiddleware<AppState, ConfirmPlaceOrderAction>(_createConfirmPlaceOrder(pzzRepository)),
  ];
}

Middleware<AppState> _createInitial(PzzRepository repository, PreferenceRepository preferenceRepository) {
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
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
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

MiddlewareTyped<AppState, SavePersonalInfoAction> _createSavePersonalInfo(PreferenceRepository repository) {
  return (Store<AppState> store, SavePersonalInfoAction action, NextDispatcher next) {
    //repository.savePersonalInfo(action.info);
    next(action);
  };
}

MiddlewareTyped<AppState, SelectStreetAction> _createSelectStreet(
    PzzRepository pzzRepository, PreferenceRepository repository) {
  return (Store<AppState> store, SelectStreetAction action, NextDispatcher next) async {
    next(action);
    //repository.savePersonalInfo(personalInfoSelector(store.state));
    final houses = await pzzRepository.loadHousesByStreet(action.street.id);
    next(LoadedHouseAction(houses));
  };
}

MiddlewareTyped<AppState, SelectHouseAction> _createSelectHouse(PreferenceRepository repository) {
  return (Store<AppState> store, SelectHouseAction action, NextDispatcher next) async {
    next(action);
    //repository.savePersonalInfo(personalInfoSelector(store.state));
  };
}

MiddlewareTyped<AppState, TryPlaceOrderAction> _createUpdateAddress(PzzRepository repository) {
  return (Store<AppState> store, TryPlaceOrderAction action, NextDispatcher next) async {
    next(action);
    if (isPersonInfoValid(store.state)) {
      repository.updateAddress(personalInfoSelector(store.state)).then((basket) {
        store.dispatch(BasketLoadedAction(basket));
        store.dispatch(ShowConfirmOrderDialogAction());
      }).catchError((ex) {
        print(ex);
      });
    }
  };
}

MiddlewareTyped<AppState, ConfirmPlaceOrderAction> _createConfirmPlaceOrder(PzzRepository repository) {
  return (Store<AppState> store, ConfirmPlaceOrderAction action, NextDispatcher next) async {
    next(action);
    store.dispatch(ConfirmLoadingAction(isLoading: true));
    repository.placeOrder().then((basket) {
      store.dispatch(BasketLoadedAction(basket));
    }).catchError((ex) {
      print(ex);
    }).whenComplete(() {
      store.dispatch(ConfirmLoadingAction(isLoading: false));
    });
  };
}
