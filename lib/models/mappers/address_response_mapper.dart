import 'package:pzz/models/basket_address.dart';
import 'package:pzz/models/dto/address_dto.dart';

class AddressResponseMapper {
  static BasketAddress map(AddressDto from) {
    return BasketAddress(
      streetId: from.streetId,
      houseId: from.houseId,
      name: from.name,
      phone: from.phone,
      street: from.street,
      house: from.house,
      flat: from.flat,
      entrance: from.entrance,
      floor: from.floor,
      intercom: from.intercom,
    );
  }
}
