import 'package:pzz/models/dto/address_dto.dart';
import 'package:pzz/models/dto/basket_item_dto.dart';

class BasketDto {
  int id;
  String sync;
  String num;
  int onEdit;
  int fullEdit;
  String createdDate;
  String clientName;
  int price;
  int total;
  int totalMixed;
  int delivery;
  int baseDelivery;
  int deliveryTime;
  int pizzeriaId;
  String pizzeriaType;
  int toEntrance;
  String publicComment;
  int couponId;
  String couponCode;
  int selfDiscount;
  int discountId;
  int discount;
  String discountType;
  String discountUnit;
  String discountComment;
  String status;
  String renting; // С какой суммы подготовить сдачу
  String itemListFlat;
  String comment;
  String failureComment;
  Null failureAcceptor;
  String phoneComment;
  String preorderDate;
  String preorderTime;
  String payment;
  Null selfDeliveryTime;
  int isDelivery;
  //int isSpecgrill;
  String specgrillComment;
  int is15Min;
  int isSlowed;
  //bool isMoved;
  int isMeal;
  int isExternal;
  int isPaymentDelivery;
  int forcePaymentDelivery;
  bool isThinPizzaAvailable;
  int isFormerEmployee;
  int isCurrentEmployee;
  int isGroupCcMeal;
  int noContactOnDelivery;
  int saveNewAddress;
  Null mealEmployeeId;
  Null mealRestrictionId;
  String external;
  String externalId;
  int isDisabledPaymentByCard;
  String basketAt;
  int isDisabledNoContactDelivery;
  String err;
  int hiddenActionDisabled;
  int halvaPreorderDisabled;
  int onlinePreorderDisabled;
  int onlineDisabled;
  int halvaDisabled;
  String routeSpell;
  int pizzeriaIsSlowed;
  List doubles;
  int freeSticksCount;
  int freeGarnishesCount;
  int freeWarmersCount;
  List<BasketItemDto> items;
  AddressDto address;
  String publicCommentHtml;

  BasketDto(
      {this.id,
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
      this.isDisabledPaymentByCard,
      this.basketAt,
      this.isDisabledNoContactDelivery,
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
      this.items,
      this.address,
      this.publicCommentHtml});

  BasketDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sync = json['sync'];
    num = json['num'];
    onEdit = json['on_edit'];
    fullEdit = json['full_edit'];
    createdDate = json['created_date'];
    clientName = json['client_name'];
    price = json['price'];
    total = json['total'];
    totalMixed = json['total_mixed'];
    delivery = json['delivery'];
    baseDelivery = json['base_delivery'];
    deliveryTime = json['delivery_time'];
    pizzeriaId = json['pizzeria_id'];
    pizzeriaType = json['pizzeria_type'];
    toEntrance = json['to_entrance'];
    publicComment = json['public_comment'];
    couponId = json['coupon_id'];
    couponCode = json['coupon_code'];
    selfDiscount = json['self_discount'];
    discountId = json['discount_id'];
    discount = json['discount'];
    discountType = json['discount_type'];
    discountUnit = json['discount_unit'];
    discountComment = json['discount_comment'];
    status = json['status'];
    renting = json['renting'];
    itemListFlat = json['item_list_flat'];
    comment = json['comment'];
    failureComment = json['failure_comment'];
    failureAcceptor = json['failure_acceptor'];
    phoneComment = json['phone_comment'];
    preorderDate = json['preorder_date'];
    preorderTime = json['preorder_time'];
    payment = json['payment'];
    selfDeliveryTime = json['self_delivery_time'];
    isDelivery = json['is_delivery'];
    //isSpecgrill = json['is_specgrill'];
    specgrillComment = json['specgrill_comment'];
    is15Min = json['is_15_min'];
    isSlowed = json['is_slowed'];
    //isMoved = json['is_moved'];
    isMeal = json['is_meal'];
    isExternal = json['is_external'];
    isPaymentDelivery = json['is_payment_delivery'];
    forcePaymentDelivery = json['force_payment_delivery'];
    isThinPizzaAvailable = json['is_thin_pizza_available'];
    isFormerEmployee = json['is_former_employee'];
    isCurrentEmployee = json['is_current_employee'];
    isGroupCcMeal = json['is_group_cc_meal'];
    noContactOnDelivery = json['no_contact_on_delivery'];
    saveNewAddress = json['save_new_address'];
    mealEmployeeId = json['meal_employee_id'];
    mealRestrictionId = json['meal_restriction_id'];
    external = json['external'];
    externalId = json['external_id'];
    isDisabledPaymentByCard = json['is_disabled_payment_by_card'];
    basketAt = json['basket_at'];
    isDisabledNoContactDelivery = json['is_disabled_no_contact_delivery'];
    err = json['err'];
    hiddenActionDisabled = json['hidden_action_disabled'];
    halvaPreorderDisabled = json['halva_preorder_disabled'];
    onlinePreorderDisabled = json['online_preorder_disabled'];
    onlineDisabled = json['online_disabled'];
    halvaDisabled = json['halva_disabled'];
    routeSpell = json['route_spell'];
    pizzeriaIsSlowed = json['pizzeria_is_slowed'];
    if (json['doubles'] != null) {
      doubles = new List();
      json['doubles'].forEach((v) {
        doubles.add(v);
      });
    }
    freeSticksCount = json['free_sticks_count'];
    freeGarnishesCount = json['free_garnishes_count'];
    freeWarmersCount = json['free_warmers_count'];
    if (json['items'] != null) {
      items = new List<BasketItemDto>();
      json['items'].forEach((v) {
        items.add(new BasketItemDto.fromJson(v));
      });
    }
    address = json['address'] != null ? new AddressDto.fromJson(json['address']) : null;
    publicCommentHtml = json['public_comment_html'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sync'] = this.sync;
    data['num'] = this.num;
    data['on_edit'] = this.onEdit;
    data['full_edit'] = this.fullEdit;
    data['created_date'] = this.createdDate;
    data['client_name'] = this.clientName;
    data['price'] = this.price;
    data['total'] = this.total;
    data['total_mixed'] = this.totalMixed;
    data['delivery'] = this.delivery;
    data['base_delivery'] = this.baseDelivery;
    data['delivery_time'] = this.deliveryTime;
    data['pizzeria_id'] = this.pizzeriaId;
    data['pizzeria_type'] = this.pizzeriaType;
    data['to_entrance'] = this.toEntrance;
    data['public_comment'] = this.publicComment;
    data['coupon_id'] = this.couponId;
    data['coupon_code'] = this.couponCode;
    data['self_discount'] = this.selfDiscount;
    data['discount_id'] = this.discountId;
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    data['discount_unit'] = this.discountUnit;
    data['discount_comment'] = this.discountComment;
    data['status'] = this.status;
    data['renting'] = this.renting;
    data['item_list_flat'] = this.itemListFlat;
    data['comment'] = this.comment;
    data['failure_comment'] = this.failureComment;
    data['failure_acceptor'] = this.failureAcceptor;
    data['phone_comment'] = this.phoneComment;
    data['preorder_date'] = this.preorderDate;
    data['preorder_time'] = this.preorderTime;
    data['payment'] = this.payment;
    data['self_delivery_time'] = this.selfDeliveryTime;
    data['is_delivery'] = this.isDelivery;
    //data['is_specgrill'] = this.isSpecgrill;
    data['specgrill_comment'] = this.specgrillComment;
    data['is_15_min'] = this.is15Min;
    data['is_slowed'] = this.isSlowed;
    //data['is_moved'] = this.isMoved;
    data['is_meal'] = this.isMeal;
    data['is_external'] = this.isExternal;
    data['is_payment_delivery'] = this.isPaymentDelivery;
    data['force_payment_delivery'] = this.forcePaymentDelivery;
    data['is_thin_pizza_available'] = this.isThinPizzaAvailable;
    data['is_former_employee'] = this.isFormerEmployee;
    data['is_current_employee'] = this.isCurrentEmployee;
    data['is_group_cc_meal'] = this.isGroupCcMeal;
    data['no_contact_on_delivery'] = this.noContactOnDelivery;
    data['save_new_address'] = this.saveNewAddress;
    data['meal_employee_id'] = this.mealEmployeeId;
    data['meal_restriction_id'] = this.mealRestrictionId;
    data['external'] = this.external;
    data['external_id'] = this.externalId;
    data['is_disabled_payment_by_card'] = this.isDisabledPaymentByCard;
    data['basket_at'] = this.basketAt;
    data['is_disabled_no_contact_delivery'] = this.isDisabledNoContactDelivery;
    data['err'] = this.err;
    data['hidden_action_disabled'] = this.hiddenActionDisabled;
    data['halva_preorder_disabled'] = this.halvaPreorderDisabled;
    data['online_preorder_disabled'] = this.onlinePreorderDisabled;
    data['online_disabled'] = this.onlineDisabled;
    data['halva_disabled'] = this.halvaDisabled;
    data['route_spell'] = this.routeSpell;
    data['pizzeria_is_slowed'] = this.pizzeriaIsSlowed;
    if (this.doubles != null) {
      data['doubles'] = this.doubles.map((v) => v.toJson()).toList();
    }
    data['free_sticks_count'] = this.freeSticksCount;
    data['free_garnishes_count'] = this.freeGarnishesCount;
    data['free_warmers_count'] = this.freeWarmersCount;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    data['public_comment_html'] = this.publicCommentHtml;
    return data;
  }
}
