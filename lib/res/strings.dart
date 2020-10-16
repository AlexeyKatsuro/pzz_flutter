abstract class StringRes {
  static const appName = 'Пиццы у Лисиццы';
  static const pizza_size_big = 'Большая';
  static const pizza_size_medium = 'Стандартная';
  static const pizza_size_thin = 'Тонкое тесто';
  static const in_basket = 'В корзину';
  static const basket = 'Корзина';
  static const total = 'Итого';
  static const delivery_address = 'Адрес доставки';
  static const your_name = 'Ваше имя';
  static const your_phone_number = 'Ваш мобильный телефон';
  static const street = 'Улица';
  static const house = 'Дом';
  static const flat = 'Квартира';
  static const entrance = 'Подъезд';
  static const floor = 'Этаж';
  static const intercom = 'Домофон';
  static const comments_to_order = 'Комментарий к заказу';
  static const save = 'Сохранить';
  static const search = 'Найти...';

  // TODO Use plurals
  static String chooseFeeSauces(int count) {
    if (count <= 0) return chooseSauces; // TODO it check should not be here
    if (count == 1) return 'Выберите $count бесплатный соус';
    return 'Выберите $count бесплатных соусов';
  }

  static const String chooseSauces = 'Выберите соус';

  static const pizzas = 'Пиццы';
  static const sauces = 'Соусы';
  static const snacks = 'Закуски';
  static const desserts = 'Дисерты';
  static const drinks = 'Напитки';
  static const deliveryAddress = 'Адресс доставки';
}
