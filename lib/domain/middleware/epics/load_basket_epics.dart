import 'package:flutter/foundation.dart';
import 'package:pzz/domain/actions/actions.dart';
import 'package:pzz/domain/error/error_message_extractor.dart';
import 'package:pzz/domain/error/scoped_error_actions.dart';
import 'package:pzz/domain/repository/pzz_repository.dart';
import 'package:pzz/models/app_state.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

class LoadBasketEpics extends EpicClass<AppState> {
  LoadBasketEpics({required this.repository, required this.scope});

  final PzzRepository repository;
  final String scope;

  @override
  Stream<dynamic> call(Stream<dynamic> actions, EpicStore<AppState> store) {
    return repository
        .loadBasket()
        .asStream()
        .map<dynamic>((basket) => BasketLoadedAction(basket))
        .onErrorReturnWith((dynamic ex) {
      debugPrint('$ex');
      return SetScopedErrorAction(error: errorMessageExtractor(ex), scope: scope);
    });
  }
}
