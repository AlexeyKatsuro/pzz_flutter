import 'package:pzz/models/sauce.dart';
import 'package:pzz/models/dto/sause_dto.dart';

class SauceItemResponseMapper {
  static Sauce map(SauceDto dto) {
    return Sauce(
      id: dto.id!,
      title: dto.title!,
      price: dto.price! / 10000,
      photo: dto.photoSmall!,
    );
  }
}
