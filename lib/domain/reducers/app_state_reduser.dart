import 'package:pzz/domain/reducers/loading_reducer.dart';
import 'package:pzz/domain/reducers/pizzas_reducer.dart';
import 'package:pzz/models/app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    isLoading: loadingReducer(state.isLoading, action),
    pizzas: pizzasReducer(state.pizzas, action),
  );
}
