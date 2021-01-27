import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/models/home_page_state.dart';
import 'package:redux/redux.dart';

final homePageStateReducer = combineReducers<HomePageState>([
  TypedReducer<HomePageState, HomeLoadingAction>(_homeLoadingReducer),
  TypedReducer<HomePageState, HomeErrorAction>(_homeErrorReducer),
  TypedReducer<HomePageState, InitialAction>(_clearErrorReducer),
]);

HomePageState _homeLoadingReducer(HomePageState state, HomeLoadingAction action) {
  return state.copyWith(isLoading: action.isLoading);
}

HomePageState _homeErrorReducer(HomePageState state, HomeErrorAction action) {
  return state.copyWith(errorMessage: action.errorMessage);
}

HomePageState _clearErrorReducer(HomePageState state, InitialAction action) {
  return state.copyWithError();
}
