import 'package:mobx/mobx.dart';
import 'package:pzz/domain/error/error_message_extractor.dart';

import 'package:pzz/domain/repository/pzz_repository.dart';
import 'package:pzz/models/pizza.dart';
import 'package:pzz/routes.dart';
import 'package:pzz/stores/navigation_store.dart';
import 'package:pzz/utils/ui_message.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  HomeStoreBase({
    required PzzRepository pzzRepository,
    required NavigationStore navigationStore,
  })  : _pzzRepository = pzzRepository,
        _navigationStore = navigationStore {
    _fetchPizzas();
  }

  final PzzRepository _pzzRepository;
  final NavigationStore _navigationStore;

  @observable
  bool isLoading = false;

  @observable
  UiMessage? errorMessage;

  @observable
  List<Pizza> pizzas = [];

  void onRepeat() {}

  @action
  void onBasketClick() {
    _navigationStore.push(Routes.basketScreen);
  }

  @action
  Future<void> _fetchPizzas() async {
    isLoading = true;
    try {
      pizzas = await _pzzRepository.loadPizzas();
    } catch (error) {
      errorMessage = errorMessageExtractor(error);
    } finally {
      isLoading = false;
    }
  }
}
