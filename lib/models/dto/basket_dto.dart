// ignore_for_file: avoid_dynamic_calls

import 'package:pzz/models/dto/address_dto.dart';
import 'package:pzz/models/dto/basket_item_dto.dart';

class BasketDto {
  BasketDto({
    this.id,
    this.sync,
    this.num,
    this.onEdit,
    this.fullEdit,
    this.createdDate,
    this.clientName,
    this.price,
    this.total,
    this.totalMixed,
    this.delivery,
    this.baseDelivery,
    this.deliveryTime,
    this.pizzeriaId,
    this.pizzeriaType,
    this.toEntrance,
    this.publicComment,
    this.couponId,
    this.couponCode,
    this.selfDiscount,
    this.discountId,
    this.discount,
    this.discountType,
    this.discountUnit,
    this.discountComment,
    this.status,
    this.renting,
    this.itemListFlat,
    this.comment,
    this.failureComment,
    this.failureAcceptor,
    this.phoneComment,
    this.preorderDate,
    this.preorderTime,
    this.payment,
    this.selfDeliveryTime,
    this.isDelivery,
    //this.isSpecgrill,
    this.specgrillComment,
    this.is15Min,
    this.isSlowed,
    //this.isMoved,
    this.isMeal,
    this.isExternal,
    this.isPaymentDelivery,
    this.forcePaymentDelivery,
    this.isThinPizzaAvailable,
    this.isFormerEmployee,
    this.isCurrentEmployee,
    this.isGroupCcMeal,
    this.noContactOnDelivery,
    this.saveNewAddress,
    this.mealEmployeeId,
    this.mealRestrictionId,
    this.external,
    this.externalId,
    //this.isDisabledPaymentByCard,
    this.basketAt,
    //    this.isDisabledNoContactDelivery,
    this.err,
    this.hiddenActionDisabled,
    this.halvaPreorderDisabled,
    this.onlinePreorderDisabled,
    this.onlineDisabled,
    this.halvaDisabled,
    this.routeSpell,
    this.pizzeriaIsSlowed,
    this.doubles,
    this.freeSticksCount,
    this.freeGarnishesCount,
    this.freeWarmersCount,
    this.items = const [],
    this.address,
    this.publicCommentHtml,
  });

  BasketDto.fromJson(Map<String, dynamic> json) : items = [] {
    id = json['id'] as int?;
    sync = json['sync'] as String?;
    num = json['num'].toString();
    onEdit = json['on_edit'] as int?;
    fullEdit = json['full_edit'] as int?;
    createdDate = json['created_date'] as String?;
    clientName = json['client_name'] as String?;
    price = json['price'] as int?;
    total = json['total'] as int?;
    totalMixed = json['total_mixed'] as int?;
    delivery = json['delivery'] as int?;
    baseDelivery = json['base_delivery'] as int?;
    deliveryTime = json['delivery_time'] as int?;
    pizzeriaId = json['pizzeria_id'] as int?;
    pizzeriaType = json['pizzeria_type'] as String?;
    toEntrance = json['to_entrance'] as int?;
    publicComment = json['public_comment'] as String?;
    couponId = json['coupon_id'] as int?;
    couponCode = json['coupon_code'] as String?;
    selfDiscount = json['self_discount'] as int?;
    discountId = json['discount_id'] as int?;
    discount = json['discount'] as int?;
    discountType = json['discount_type'] as String?;
    discountUnit = json['discount_unit'] as String?;
    discountComment = json['discount_comment'] as String?;
    status = json['status'] as String?;
    renting = json['renting'] as String?;
    itemListFlat = json['item_list_flat'] as String?;
    comment = json['comment'] as String?;
    failureComment = json['failure_comment'] as String?;
    failureAcceptor = json['failure_acceptor'] as Object?;
    phoneComment = json['phone_comment'] as String?;
    preorderDate = json['preorder_date'] as String?;
    preorderTime = json['preorder_time'] as String?;
    payment = json['payment'] as String?;
    selfDeliveryTime = json['self_delivery_time'] as Object?;
    isDelivery = json['is_delivery'] as int?;
    //isSpecgrill = json['is_specgrill'];
    specgrillComment = json['specgrill_comment'] as String?;
    is15Min = json['is_15_min'] as int?;
    isSlowed = json['is_slowed'] as int?;
    //isMoved = json['is_moved'];
    isMeal = json['is_meal'] as int?;
    isExternal = json['is_external'] as int?;
    isPaymentDelivery = json['is_payment_delivery'] as int?;
    forcePaymentDelivery = json['force_payment_delivery'] as int?;
    isThinPizzaAvailable = json['is_thin_pizza_available'] as bool?;
    isFormerEmployee = json['is_former_employee'] as int?;
    isCurrentEmployee = json['is_current_employee'] as int?;
    isGroupCcMeal = json['is_group_cc_meal'] as int?;
    noContactOnDelivery = json['no_contact_on_delivery'] as int?;
    saveNewAddress = json['save_new_address'] as int?;
    mealEmployeeId = json['meal_employee_id'] as Object?;
    mealRestrictionId = json['meal_restriction_id'] as Object?;
    external = json['external'] as String?;
    externalId = json['external_id'] as String?;
    //isDisabledPaymentByCard = json['is_disabled_payment_by_card'];
    basketAt = json['basket_at'] as String?;
//    isDisabledNoContactDelivery = json['is_disabled_no_contact_delivery'];
    err = json['err'] as String?;
    hiddenActionDisabled = json['hidden_action_disabled'] as int?;
    halvaPreorderDisabled = json['halva_preorder_disabled'] as int?;
    onlinePreorderDisabled = json['online_preorder_disabled'] as int?;
    onlineDisabled = json['online_disabled'] as int?;
    halvaDisabled = json['halva_disabled'] as int?;
    routeSpell = json['route_spell'] as String?;
    pizzeriaIsSlowed = json['pizzeria_is_slowed'] as int?;
    items = [];
    if (json['doubles'] != null) {
      doubles = [];
      json['doubles'].forEach((v) {
        doubles!.add(v);
      });
    }
    freeSticksCount = json['free_sticks_count'] as int?;
    freeGarnishesCount = json['free_garnishes_count'] as int?;
    freeWarmersCount = json['free_warmers_count'] as int?;

    if (json['items'] != null) {
      json['items'].forEach((v) {
        items.add(BasketItemDto.fromJson(v as Map<String, dynamic>));
      });
    } else {
      items = [];
    }
    address = json['address'] != null
        ? AddressDto.fromJson(json['address'] as Map<String, dynamic>)
        : null;
    publicCommentHtml = json['public_comment_html'] as String?;
  }

  int? id;
  String? sync;
  String? num;
  int? onEdit;
  int? fullEdit;
  String? createdDate;
  String? clientName;
  int? price;
  int? total;
  int? totalMixed;
  int? delivery;
  int? baseDelivery;
  int? deliveryTime;
  int? pizzeriaId;
  String? pizzeriaType;
  int? toEntrance;
  String? publicComment;
  int? couponId;
  String? couponCode;
  int? selfDiscount;
  int? discountId;
  int? discount;
  String? discountType;
  String? discountUnit;
  String? discountComment;
  String? status;
  String? renting; // С какой суммы подготовить сдачу
  String? itemListFlat;
  String? comment;
  String? failureComment;
  Object? failureAcceptor;
  String? phoneComment;
  String? preorderDate;
  String? preorderTime;
  String? payment;
  Object? selfDeliveryTime;
  int? isDelivery;

  //int isSpecgrill;
  String? specgrillComment;
  int? is15Min;
  int? isSlowed;

  //bool isMoved;
  int? isMeal;
  int? isExternal;
  int? isPaymentDelivery;
  int? forcePaymentDelivery;
  bool? isThinPizzaAvailable;
  int? isFormerEmployee;
  int? isCurrentEmployee;
  int? isGroupCcMeal;
  int? noContactOnDelivery;
  int? saveNewAddress;
  Object? mealEmployeeId;
  Object? mealRestrictionId;
  String? external;
  String? externalId;

  //int isDisabledPaymentByCard; bool/int
  String? basketAt;

  // int isDisabledNoContactDelivery; bool/int
  String? err;
  int? hiddenActionDisabled;
  int? halvaPreorderDisabled;
  int? onlinePreorderDisabled;
  int? onlineDisabled;
  int? halvaDisabled;
  String? routeSpell;
  int? pizzeriaIsSlowed;
  List? doubles;
  int? freeSticksCount;
  int? freeGarnishesCount;
  int? freeWarmersCount;
  List<BasketItemDto> items;
  AddressDto? address;
  String? publicCommentHtml;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sync'] = sync;
    data['num'] = num;
    data['on_edit'] = onEdit;
    data['full_edit'] = fullEdit;
    data['created_date'] = createdDate;
    data['client_name'] = clientName;
    data['price'] = price;
    data['total'] = total;
    data['total_mixed'] = totalMixed;
    data['delivery'] = delivery;
    data['base_delivery'] = baseDelivery;
    data['delivery_time'] = deliveryTime;
    data['pizzeria_id'] = pizzeriaId;
    data['pizzeria_type'] = pizzeriaType;
    data['to_entrance'] = toEntrance;
    data['public_comment'] = publicComment;
    data['coupon_id'] = couponId;
    data['coupon_code'] = couponCode;
    data['self_discount'] = selfDiscount;
    data['discount_id'] = discountId;
    data['discount'] = discount;
    data['discount_type'] = discountType;
    data['discount_unit'] = discountUnit;
    data['discount_comment'] = discountComment;
    data['status'] = status;
    data['renting'] = renting;
    data['item_list_flat'] = itemListFlat;
    data['comment'] = comment;
    data['failure_comment'] = failureComment;
    data['failure_acceptor'] = failureAcceptor;
    data['phone_comment'] = phoneComment;
    data['preorder_date'] = preorderDate;
    data['preorder_time'] = preorderTime;
    data['payment'] = payment;
    data['self_delivery_time'] = selfDeliveryTime;
    data['is_delivery'] = isDelivery;
    //data['is_specgrill'] = this.isSpecgrill;
    data['specgrill_comment'] = specgrillComment;
    data['is_15_min'] = is15Min;
    data['is_slowed'] = isSlowed;
    //data['is_moved'] = this.isMoved;
    data['is_meal'] = isMeal;
    data['is_external'] = isExternal;
    data['is_payment_delivery'] = isPaymentDelivery;
    data['force_payment_delivery'] = forcePaymentDelivery;
    data['is_thin_pizza_available'] = isThinPizzaAvailable;
    data['is_former_employee'] = isFormerEmployee;
    data['is_current_employee'] = isCurrentEmployee;
    data['is_group_cc_meal'] = isGroupCcMeal;
    data['no_contact_on_delivery'] = noContactOnDelivery;
    data['save_new_address'] = saveNewAddress;
    data['meal_employee_id'] = mealEmployeeId;
    data['meal_restriction_id'] = mealRestrictionId;
    data['external'] = external;
    data['external_id'] = externalId;
    // data['is_disabled_payment_by_card'] = isDisabledPaymentByCard;
    data['basket_at'] = basketAt;
    // data['is_disabled_no_contact_delivery'] = isDisabledNoContactDelivery;
    data['err'] = err;
    data['hidden_action_disabled'] = hiddenActionDisabled;
    data['halva_preorder_disabled'] = halvaPreorderDisabled;
    data['online_preorder_disabled'] = onlinePreorderDisabled;
    data['online_disabled'] = onlineDisabled;
    data['halva_disabled'] = halvaDisabled;
    data['route_spell'] = routeSpell;
    data['pizzeria_is_slowed'] = pizzeriaIsSlowed;
    if (doubles != null) {
      data['doubles'] = doubles!.map((v) => v.toJson()).toList();
    }
    data['free_sticks_count'] = freeSticksCount;
    data['free_garnishes_count'] = freeGarnishesCount;
    data['free_warmers_count'] = freeWarmersCount;
    data['items'] = items.map((v) => v.toJson()).toList();
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['public_comment_html'] = publicCommentHtml;
    return data;
  }
}
