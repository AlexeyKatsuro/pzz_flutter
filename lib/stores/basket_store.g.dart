// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BasketStore on BasketStoreBase, Store {
  Computed<Map<ProductType, List<BasketProduct>>>? _$productsByTypeComputed;

  @override
  Map<ProductType, List<BasketProduct>> get productsByType => (_$productsByTypeComputed ??=
          Computed<Map<ProductType, List<BasketProduct>>>(() => super.productsByType,
              name: 'BasketStoreBase.productsByType'))
      .value;
  Computed<Map<ProductType, List<CombinedBasketProduct>>>? _$combinedProductByComputed;

  @override
  Map<ProductType, List<CombinedBasketProduct>> get combinedProductBy =>
      (_$combinedProductByComputed ??= Computed<Map<ProductType, List<CombinedBasketProduct>>>(
              () => super.combinedProductBy,
              name: 'BasketStoreBase.combinedProductBy'))
          .value;

  late final _$basketAtom = Atom(name: 'BasketStoreBase.basket', context: context);

  @override
  BasketEntity get basket {
    _$basketAtom.reportRead();
    return super.basket;
  }

  @override
  set basket(BasketEntity value) {
    _$basketAtom.reportWrite(value, super.basket, () {
      super.basket = value;
    });
  }

  late final _$onAddPizzaClickAsyncAction =
      AsyncAction('BasketStoreBase.onAddPizzaClick', context: context);

  @override
  Future<void> onAddPizzaClick(Pizza pizza, ProductSize size) {
    return _$onAddPizzaClickAsyncAction.run(() => super.onAddPizzaClick(pizza, size));
  }

  late final _$onRemovePizzaClickAsyncAction =
      AsyncAction('BasketStoreBase.onRemovePizzaClick', context: context);

  @override
  Future<void> onRemovePizzaClick(Pizza pizza, ProductSize size) {
    return _$onRemovePizzaClickAsyncAction.run(() => super.onRemovePizzaClick(pizza, size));
  }

  late final _$_fetchBasketAsyncAction =
      AsyncAction('BasketStoreBase._fetchBasket', context: context);

  @override
  Future<void> _fetchBasket() {
    return _$_fetchBasketAsyncAction.run(() => super._fetchBasket());
  }

  @override
  String toString() {
    return '''
basket: ${basket},
productsByType: ${productsByType},
combinedProductBy: ${combinedProductBy}
    ''';
  }
}
