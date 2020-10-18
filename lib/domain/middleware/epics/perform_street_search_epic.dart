import 'package:pzz/domain/person_info_form/actions/person_info_form_actions.dart';
import 'package:pzz/domain/repository/pzz_repository.dart';
import 'package:pzz/models/app_state.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

class PerformStreetSearchEpic implements EpicClass<AppState> {
  final PzzRepository repository;

  PerformStreetSearchEpic(this.repository);

  @override
  Stream<dynamic> call(Stream<dynamic> actions, EpicStore<AppState> store) {
    return actions.whereType<PerformStreetSearchAction>().debounceTime(Duration(milliseconds: 300)).switchMap((action) {
      if (action.query.length >= 2) {
        return Stream.fromFuture(repository
                .searchStreet(action.query)
                .then((streets) => SearchStreetResultAction(streets))
                .catchError((error) => SearchStreetErrorAction(error)))
            .takeUntil(actions.whereType<CancelStreetSearchAction>());
      } else {
        return Stream.value(SearchStreetResultAction([]));
      }
    });
  }
}
