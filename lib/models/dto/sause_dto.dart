class SauceDto {
  int id;
  String title;
  String titleInner;
  String photoSmall;
  String photo;
  String description;
  num price;
  bool inStock;

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
    id = json['id'];
    title = json['title'];
    titleInner = json['title_inner'];
    photoSmall = json['photo_small'];
    photo = json['photo'];
    description = json['description'];
    price = json['price'];
    inStock = json['in_stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['title_inner'] = this.titleInner;
    data['photo_small'] = this.photoSmall;
    data['photo'] = this.photo;
    data['description'] = this.description;
    data['price'] = this.price;
    data['in_stock'] = this.inStock;
    return data;
  }
}
