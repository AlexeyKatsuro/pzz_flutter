abstract class StringRes {
  static const appName = 'Пиццы у Лисиццы';
  static const pizza_size_big = 'Большая';
  static const pizza_size_medium = 'Стандартная';
  static const pizza_size_thin = 'Тонкое тесто';
  static const in_basket = 'В корзину';
  static const basket = 'Корзина';
  static const total_price = 'Итого';
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
  static const repeat = 'Повторить';

  // TODO Use plurals
  static String chooseFeeSauces(int count) {
    if (count == 1) return 'Выберите $count бесплатный соус';
    if (count >= 2 && count < 5) return 'Выберите $count бесплатных соуса';
    return 'Выберите $count бесплатных соусов';
  }

  static const String addSauces = 'Добавить соус';

  static const pizzas = 'Пиццы';
  static const sauces = 'Соусы';
  static const snacks = 'Закуски';
  static const desserts = 'Дисерты';
  static const drinks = 'Напитки';

  static const payment_way = 'Способы оплаты';
  static const charge = 'Картой';
  static const cash = 'Наличными';
  static const online = 'Онлайн';
  static const halva = 'Халва';
  static const prepare_to_charge = 'С какой суммы подготовить сдачу?';
  static const place_order = 'К подтверждению';

  static const error_empty_phone = 'Введите номер телефона';
  static const error_empty_street = 'Выберите название улицы';
  static const error_empty_home = 'Выберите номер дома';
  static const error_empty_payment_pay = 'Выберите способ оплаты';
  static const error_connection = 'Ошибка подлючения, проверьте соединение с интернетом';
  static const error_unexpected = 'Неизвестная ошибка';
  static const error_404 = '404';
  static const error_404_message = 'Стараница не найдена';

  static const to_confirm_title = 'Подтвердите заказ';
  static const to_confirm_phone = 'Контактный телефон';
  static const to_confirm_address = 'На адрес';
  static const to_confirm_button = 'Оформить заказ';
  static const to_confirm_total_price = 'К оплате:';
  static String streetHouse(String street, String house) => 'ул. $street, д. $house';
  static String streetHouseFlat(String street, String house, String flat) => 'ул. $street, д. $house, кв. $flat';
}
