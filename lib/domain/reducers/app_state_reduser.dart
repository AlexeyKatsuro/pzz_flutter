import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/domain/error/scoped_error_hub_reducer.dart';
import 'package:pzz/domain/reducers/basket_reducer.dart';
import 'package:pzz/domain/reducers/home_page_reducer.dart';
import 'package:pzz/domain/reducers/personal_info_reducer.dart';
import 'package:pzz/domain/reducers/pizzas_reducer.dart';
import 'package:pzz/domain/reducers/sauces_reducer.dart';
import 'package:pzz/models/app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
      scopedErrors: scopedErrorHubReducer(state.scopedErrors, action),
      homePageState: homePageStateReducer(state.homePageState, action),
      pizzas: pizzasReducer(state.pizzas, action),
      sauce: saucesReducer(state.sauce, action),
      basket: basketReducer(state.basket, action),
      personalInfoState: personalInfoStateReducer(state.personalInfoState, action),
      showConfirmOrderDialogEvent: showConfirmOrderDialogEventReducer(state.showConfirmOrderDialogEvent, action),
      isConfirmLoading: confirmLoadingReducer(state.isConfirmLoading, action));
}

bool showConfirmOrderDialogEventReducer(bool previousValue, dynamic action) {
  if (action is ShowConfirmOrderDialogAction) {
    return true;
  } else if (action is HandleConfirmOrderDialogAction) {
    return false;
  } else {
    return previousValue;
  }
}

bool confirmLoadingReducer(bool previousValue, dynamic action) {
  if (action is ConfirmLoadingAction) {
    return action.isLoading;
  } else {
    return previousValue;
  }
}
