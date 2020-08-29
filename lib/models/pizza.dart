import 'package:flutter/foundation.dart';
import 'package:pzz/models/pizza_variant.dart';

@immutable
class Pizza {
  final int id;
  final String name;
  final String description;
  final String thumbnail;
  final String photo;
  final List<PizzaVariant> variants;

  Pizza(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.thumbnail,
      @required this.variants,
      @required this.photo})
      : assert(id != null),
        assert(name != null),
        assert(description != null),
        assert(thumbnail != null),
        assert(variants != null),
        assert(photo != null);

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

enum PizzaSize { big, medium, thin }

extension PizzaSizeExt on PizzaSize {
  String get name => describeEnum(this);
}
