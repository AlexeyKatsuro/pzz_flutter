import 'package:pzz/models/app_state.dart';
import 'package:redux/redux.dart';

int basketCountSelector(Store<AppState> store) {
  return store.state.basket?.items?.length ?? 0;
}
