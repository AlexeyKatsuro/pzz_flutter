import 'package:pzz/models/person_info/personal_info.dart';

class PersonalInfoDto {
  const PersonalInfoDto({
    this.streetId,
    this.houseId,
    this.name,
    this.phone,
    this.street,
    this.house,
    this.flat,
    this.entrance,
    this.floor,
    this.intercom,
    this.comment,
  });

  PersonalInfoDto.fromJson(Map<String, dynamic> json)
      : streetId = json['street_id'] as int?,
        houseId = json['house_id'] as int?,
        name = json['name'] as String?,
        phone = json['phone'] as String?,
        street = json['street'] as String?,
        house = json['house'] as String?,
        flat = json['flat'] as String?,
        entrance = json['entrance'] as String?,
        floor = json['floor'] as String?,
        intercom = json['intercom'] as String?,
        comment = json['comment'] as String?;

  PersonalInfoDto.fromModel(PersonalInfo model)
      : streetId = model.streetId,
        houseId = model.houseId,
        name = model.name,
        phone = model.phone,
        street = model.street,
        house = model.house,
        flat = model.flat,
        entrance = model.entrance,
        floor = model.floor,
        intercom = model.intercom,
        comment = model.comment;

  final int? streetId;
  final int? houseId;
  final String? name;
  final String? phone;
  final String? street;
  final String? house;
  final String? flat;
  final String? entrance;
  final String? floor;
  final String? intercom;
  final String? comment;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['street_id'] = streetId;
    data['house_id'] = houseId;
    data['name'] = name;
    data['phone'] = phone;
    data['street'] = street;
    data['house'] = house;
    data['flat'] = flat;
    data['entrance'] = entrance;
    data['floor'] = floor;
    data['intercom'] = intercom;
    data['comment'] = comment;
    return data;
  }

  PersonalInfo toModel() {
    return PersonalInfo(
      streetId: streetId!,
      houseId: houseId!,
      name: name!,
      phone: phone!,
      street: street!,
      house: house!,
      flat: flat!,
      entrance: entrance!,
      floor: floor!,
      intercom: intercom!,
      comment: comment!,
    );
  }
}
