class BasketItemDto {
  String type;
  int id;
  String size;
  String dough;
  int isFailure;
  bool is3in2;
  bool withSauce;
  int parts;
  int itemId;
  bool isNew;
  bool autoRemoved;
  String title;
  int freeSaucesCount;
  int toRemove;
  int toSoftRemove;
  int packed;
  int prepared;
  int isFree;
  num price;

  BasketItemDto(
      {this.type,
      this.id,
      this.size,
      this.dough,
      this.isFailure,
      this.is3in2,
      this.withSauce,
      this.parts,
      this.itemId,
      this.isNew,
      this.autoRemoved,
      this.title,
      this.freeSaucesCount,
      this.toRemove,
      this.toSoftRemove,
      this.packed,
      this.prepared,
      this.isFree,
      this.price});

  BasketItemDto.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = int.parse(json['id']);
    size = json['size'];
    dough = json['dough'];
    isFailure = json['is_failure'];
    is3in2 = json['is_3in2'];
    withSauce = json['with_sauce'];
    parts = json['parts'];
    itemId = json['item_id'];
    isNew = json['is_new'];
    autoRemoved = json['auto_removed'];
    title = json['title'];
    freeSaucesCount = json['free_sauces_count'];
    toRemove = json['to_remove'];
    toSoftRemove = json['to_soft_remove'];
    packed = json['packed'];
    prepared = json['prepared'];
    isFree = json['is_free'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['id'] = this.id;
    data['size'] = this.size;
    data['dough'] = this.dough;
    data['is_failure'] = this.isFailure;
    data['is_3in2'] = this.is3in2;
    data['with_sauce'] = this.withSauce;
    data['parts'] = this.parts;
    data['item_id'] = this.itemId;
    data['is_new'] = this.isNew;
    data['auto_removed'] = this.autoRemoved;
    data['title'] = this.title;
    data['free_sauces_count'] = this.freeSaucesCount;
    data['to_remove'] = this.toRemove;
    data['to_soft_remove'] = this.toSoftRemove;
    data['packed'] = this.packed;
    data['prepared'] = this.prepared;
    data['is_free'] = this.isFree;
    data['price'] = this.price;
    return data;
  }
}
