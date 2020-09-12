import 'package:pzz/models/personal_info.dart';

class PersonalInfoDto {
  final int streetId;
  final int houseId;
  final String name;
  final String phone;
  final String street;
  final String house;
  final String flat;
  final String entrance;
  final String floor;
  final String intercom;
  final String comment;

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
      : streetId = json['street_id'],
        houseId = json['house_id'],
        name = json['name'],
        phone = json['phone'],
        street = json['street'],
        house = json['house'],
        flat = json['flat'],
        entrance = json['entrance'],
        floor = json['floor'],
        intercom = json['intercom'],
        comment = json['comment'];

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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street_id'] = this.streetId;
    data['house_id'] = this.houseId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['street'] = this.street;
    data['house'] = this.house;
    data['flat'] = this.flat;
    data['entrance'] = this.entrance;
    data['floor'] = this.floor;
    data['intercom'] = this.intercom;
    data['comment'] = this.comment;
    return data;
  }

  PersonalInfo toModel() {
    return PersonalInfo(
      streetId: this.streetId,
      houseId: this.houseId,
      name: this.name,
      phone: this.phone,
      street: this.street,
      house: this.house,
      flat: this.flat,
      entrance: this.entrance,
      floor: this.floor,
      intercom: this.intercom,
      comment: this.comment,
    );
  }
}
