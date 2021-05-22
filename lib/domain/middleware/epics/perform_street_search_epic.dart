import 'package:pzz/domain/error/error_message_extractor.dart';
import 'package:pzz/domain/error/scoped_error_actions.dart';
import 'package:pzz/domain/person_info_form/actions/person_info_form_actions.dart';
import 'package:pzz/domain/repository/pzz_repository.dart';
import 'package:pzz/models/app_state.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

class PerformStreetSearchEpic implements EpicClass<AppState> {
  PerformStreetSearchEpic(this.repository);

  final PzzRepository repository;

  @override
  Stream<dynamic> call(Stream<dynamic> actions, EpicStore<AppState> store) {
    return actions
        .whereType<PerformStreetSearchAction>()
        .debounceTime(const Duration(milliseconds: 300))
        .switchMap((action) {
      if (action.query.length >= 2) {
        return repository
            .searchStreet(action.query)
            .asStream()
            .map<dynamic>((streets) => SearchStreetResultAction(streets))
            .onErrorResume(
                (error) => Stream.value(SetScopedErrorAction(error: errorMessageExtractor(error), scope: action.scope)))
            .takeUntil(actions.whereType<CancelStreetSearchAction>());
      } else {
        return Stream.value(SearchStreetResultAction([]));
      }
    });
  }
}
