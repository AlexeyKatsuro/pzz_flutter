class SauceDto {
  SauceDto({
    this.id,
    this.title,
    this.titleInner,
    this.photoSmall,
    this.photo,
    this.description,
    this.price,
    this.inStock,
  });

  SauceDto.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    title = json['title'] as String?;
    titleInner = json['title_inner'] as String?;
    photoSmall = json['photo_small'] as String?;
    photo = json['photo'] as String?;
    description = json['description'] as String?;
    price = json['price'] as num?;
    inStock = json['in_stock'] as bool?;
  }

  int? id;
  String? title;
  String? titleInner;
  String? photoSmall;
  String? photo;
  String? description;
  num? price;
  bool? inStock;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['title_inner'] = titleInner;
    data['photo_small'] = photoSmall;
    data['photo'] = photo;
    data['description'] = description;
    data['price'] = price;
    data['in_stock'] = inStock;
    return data;
  }
}
