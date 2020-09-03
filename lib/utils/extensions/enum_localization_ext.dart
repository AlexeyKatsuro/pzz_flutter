import 'package:pzz/models/pizza.dart';
import 'package:pzz/res/strings.dart';
import 'package:pzz/utils/describe_enum.dart';

extension PizzaSizeLocalExt on PizzaSize {
  static Map<PizzaSize, String> _localizedMap = {
    PizzaSize.big: StringRes.pizza_size_big,
    PizzaSize.medium: StringRes.pizza_size_medium,
    PizzaSize.thin: StringRes.pizza_size_thin
  };

  static PizzaSize fromString(String size) {
    final sizeEnum = PizzaSize.values.firstWhere((element) => element.name == size);
    assert(sizeEnum != null);
    return sizeEnum;
  }

  String get localizedString => PizzaSizeLocalExt._localizedMap[this];
}
