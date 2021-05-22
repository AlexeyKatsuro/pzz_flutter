import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/foundation.dart';
import 'package:pzz/models/pizza_variant.dart';

@immutable
class Pizza {
  const Pizza({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnail,
    required this.variants,
    required this.photo,
  });

  final int id;
  final String name;
  final String description;
  final String thumbnail;
  final String photo;
  final List<PizzaVariant> variants;

  ProductType get type => ProductType.pizza;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pizza &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          thumbnail == other.thumbnail &&
          photo == other.photo &&
          variants == other.variants;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ description.hashCode ^ thumbnail.hashCode ^ photo.hashCode ^ variants.hashCode;

  @override
  String toString() {
    return 'Pizza{id: $id, name: $name, description: $description, thumbnail: $thumbnail, photo: $photo, variants: $variants}';
  }
}

enum ProductSize { big, medium, thin }
enum ProductType { pizza, sauce, snack, dessert, drink }

extension ProductSizeExt on ProductSize {
  String get name => describeEnum(this);

  static ProductSize? fromStringOrNull(String? size) {
    final sizeEnum = ProductSize.values.firstWhereOrNull((element) => element.name == size);
    return sizeEnum;
  }
}

extension ProductTypeExt on ProductType {
  String get name => describeEnum(this);

  static ProductType? fromStringOrNull(String? size) {
    final sizeEnum = ProductType.values.firstWhereOrNull((element) => element.name == size);
    return sizeEnum;
  }
}
