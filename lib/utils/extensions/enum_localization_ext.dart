import 'package:pzz/models/pizza.dart';
import 'package:pzz/res/strings.dart';

extension PizzaSizeLocalExt on PizzaSize {
  static Map<PizzaSize, String> _localizedMap = {
    PizzaSize.big: StringRes.pizza_size_big,
    PizzaSize.medium: StringRes.pizza_size_medium,
    PizzaSize.thin: StringRes.pizza_size_thin
  };

  String get localizedString => PizzaSizeLocalExt._localizedMap[this];
}
