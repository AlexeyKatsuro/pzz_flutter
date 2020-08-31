class AddressDto {
  int streetId;
  int houseId;
  String name;
  String phone;
  String street;
  String house;
  String flat;
  String entrance;
  String floor;
  String intercom;

  AddressDto(
      {this.streetId,
      this.houseId,
      this.name,
      this.phone,
      this.street,
      this.house,
      this.flat,
      this.entrance,
      this.floor,
      this.intercom});

  AddressDto.fromJson(Map<String, dynamic> json) {
    streetId = json['street_id'];
    houseId = json['house_id'];
    name = json['name'];
    phone = json['phone'];
    street = json['street'];
    house = json['house'];
    flat = json['flat'];
    entrance = json['entrance'];
    floor = json['floor'];
    intercom = json['intercom'];
  }

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
    return data;
  }
}
