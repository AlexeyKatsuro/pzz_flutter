import 'package:flutter/foundation.dart';
import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/domain/actions/navigate_to_action.dart';
import 'package:pzz/domain/error/error_message_extractor.dart';
import 'package:pzz/domain/error/scoped_error_actions.dart';
import 'package:pzz/domain/person_info_form/actions/person_info_form_actions.dart';
import 'package:pzz/domain/repository/preference_repository.dart';
import 'package:pzz/domain/repository/pzz_repository.dart';
import 'package:pzz/domain/selectors/selector.dart';
import 'package:pzz/models/app_state.dart';
import 'package:pzz/routes.dart';
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
    TypedMiddleware<AppState, LoadHousesAction>(_createLoadHouses(pzzRepository, preferenceRepository)),
    TypedMiddleware<AppState, SelectHouseAction>(_createSelectHouse(preferenceRepository)),
    TypedMiddleware<AppState, TryPlaceOrderAction>(_createUpdateAddress(pzzRepository)),
    TypedMiddleware<AppState, ConfirmPlaceOrderAction>(_createConfirmPlaceOrder(pzzRepository)),
  ];
}

MiddlewareTyped<AppState, InitialAction> _createInitial(
    PzzRepository repository, PreferenceRepository preferenceRepository) {
  return (Store<AppState> store, InitialAction action, NextDispatcher next) async {
    next(action);
    next(HomeLoadingAction(isLoading: true));
    try {
      final pizzas = repository.loadPizzas();
      final sauces = repository.loadSauces();
      next(PizzasLoadedAction(await pizzas));
      next(SaucesLoadedAction(await sauces));

      final basket = await repository.loadBasket();
      next(BasketLoadedAction(basket));
    } catch (ex) {
      debugPrint('$ex');
      next(HomeErrorAction(errorMessageExtractor(ex)));
    }
    next(HomeLoadingAction(isLoading: false));
  };
}

MiddlewareTyped<AppState, LoadPizzasAction> _createLoadPizzas(PzzRepository repository) {
  return (Store<AppState> store, LoadPizzasAction action, NextDispatcher next) async {
    repository.loadPizzas().then((pizzas) {
      next(PizzasLoadedAction(pizzas));
    }).catchError((Object ex) {
      debugPrint('$ex');
      next(SetScopedErrorAction(error: errorMessageExtractor(ex), scope: action.scope));
    });

    next(action);
  };
}

MiddlewareTyped<AppState, LoadBasketAction> _createLoadBasket(PzzRepository repository) {
  return (Store<AppState> store, LoadBasketAction action, NextDispatcher next) {
    repository.loadBasket().then((basket) {
      next(BasketLoadedAction(basket));
    }).catchError((Object ex) {
      debugPrint('$ex');
      next(SetScopedErrorAction(error: errorMessageExtractor(ex), scope: action.scope));
    });

    next(action);
  };
}

MiddlewareTyped<AppState, AddProductAction> _createAddPizzaItem(PzzRepository repository) {
  return (Store<AppState> store, AddProductAction action, NextDispatcher next) {
    repository.addProductToBasket(action.product).then((basket) {
      next(BasketLoadedAction(basket));
    }).catchError((Object ex) {
      debugPrint('$ex');
      next(SetScopedErrorAction(error: errorMessageExtractor(ex), scope: action.scope));
    });
    next(action);
  };
}

MiddlewareTyped<AppState, RemoveProductAction> _createRemovePizzaItem(PzzRepository repository) {
  return (Store<AppState> store, RemoveProductAction action, NextDispatcher next) {
    repository.removeProductFromBasket(action.product).then((basket) {
      next(BasketLoadedAction(basket));
    }).catchError((Object ex) {
      debugPrint('$ex');
      next(SetScopedErrorAction(error: errorMessageExtractor(ex), scope: action.scope));
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

MiddlewareTyped<AppState, LoadHousesAction> _createLoadHouses(
    PzzRepository pzzRepository, PreferenceRepository repository) {
  return (Store<AppState> store, LoadHousesAction action, NextDispatcher next) async {
    //repository.savePersonalInfo(personalInfoSelector(store.state));
    pzzRepository.loadHousesByStreet(action.streetId).then((houses) {
      next(LoadedHouseAction(houses));
    }).catchError((Object ex) {
      debugPrint('$ex');
      next(SetScopedErrorAction(error: errorMessageExtractor(ex), scope: action.scope));
    });
    next(action);
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
      next(ConfirmLoadingAction(isLoading: true));
      repository.updateAddress(personalInfoSelector(store.state)).then((basket) {
        next(BasketLoadedAction(basket));
        next(NavigateAction.push(Routes.confirmPlaceOrderDialog));
      }).catchError((Object ex) {
        debugPrint('$ex');
        next(SetScopedErrorAction(error: errorMessageExtractor(ex), scope: action.scope));
      }).whenComplete(() {
        next(ConfirmLoadingAction(isLoading: false));
      });
    }
  };
}

MiddlewareTyped<AppState, ConfirmPlaceOrderAction> _createConfirmPlaceOrder(PzzRepository repository) {
  return (Store<AppState> store, ConfirmPlaceOrderAction action, NextDispatcher next) async {
    next(action);
    next(ConfirmLoadingAction(isLoading: true));
    repository.placeOrder().then((basket) {
      next(NavigateAction.push(Routes.successOrderPlacedDialog));
      next(BasketLoadedAction(basket));
    }).catchError((Object ex) {
      debugPrint('$ex');
      next(SetScopedErrorAction(error: errorMessageExtractor(ex), scope: action.scope));
    }).whenComplete(() {
      next(ConfirmLoadingAction(isLoading: false));
    });
  };
}
