class AddressDto {
  AddressDto({
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
  });

  AddressDto.fromJson(Map<String, dynamic> json) {
    streetId = json['street_id'] as int?;
    houseId = json['house_id'] as int?;
    name = json['name'] as String?;
    phone = json['phone'] as String?;
    street = json['street'] as String?;
    house = json['house'] as String?;
    flat = json['flat'] as String?;
    entrance = json['entrance'] as String?;
    floor = json['floor'] as String?;
    intercom = json['intercom'] as String?;
  }

  int? streetId;
  int? houseId;
  String? name;
  String? phone;
  String? street;
  String? house;
  String? flat;
  String? entrance;
  String? floor;
  String? intercom;

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
    return data;
  }
}
