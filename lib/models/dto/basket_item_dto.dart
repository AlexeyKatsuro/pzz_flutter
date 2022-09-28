class BasketItemDto {
  BasketItemDto({
    this.type,
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
    this.price,
  });

  BasketItemDto.fromJson(Map<String, dynamic> json) {
    type = json['type'] as String?;
    id = int.parse(json['id'] as String);
    size = json['size'] as String?;
    dough = json['dough'] as String?;
    isFailure = json['is_failure'] as int?;
    is3in2 = json['is_3in2'] as bool?;
    withSauce = json['with_sauce'] as bool?;
    parts = json['parts'] as int?;
    itemId = json['item_id'] as int?;
    isNew = json['is_new'] as bool?;
    autoRemoved = json['auto_removed'] as bool?;
    title = json['title'] as String?;
    freeSaucesCount = json['free_sauces_count'] as int?;
    toRemove = json['to_remove'] as int?;
    toSoftRemove = json['to_soft_remove'] as int?;
    packed = json['packed'] as int?;
    prepared = json['prepared'] as int?;
    isFree = json['is_free'] as int?;
    price = json['price'] as num?;
  }

  String? type;
  int? id;
  String? size;
  String? dough;
  int? isFailure;
  bool? is3in2;
  bool? withSauce;
  int? parts;
  int? itemId;
  bool? isNew;
  bool? autoRemoved;
  String? title;
  int? freeSaucesCount;
  int? toRemove;
  int? toSoftRemove;
  int? packed;
  int? prepared;
  int? isFree;
  num? price;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['id'] = id;
    data['size'] = size;
    data['dough'] = dough;
    data['is_failure'] = isFailure;
    data['is_3in2'] = is3in2;
    data['with_sauce'] = withSauce;
    data['parts'] = parts;
    data['item_id'] = itemId;
    data['is_new'] = isNew;
    data['auto_removed'] = autoRemoved;
    data['title'] = title;
    data['free_sauces_count'] = freeSaucesCount;
    data['to_remove'] = toRemove;
    data['to_soft_remove'] = toSoftRemove;
    data['packed'] = packed;
    data['prepared'] = prepared;
    data['is_free'] = isFree;
    data['price'] = price;
    return data;
  }
}
