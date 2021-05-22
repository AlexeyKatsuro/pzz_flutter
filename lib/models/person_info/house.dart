import 'package:flutter/foundation.dart';

@immutable
class House {
  const House({
    required this.id,
    required this.title,
  });

  final int id;
  final String title;

  @override
  String toString() {
    return 'Street{id: $id, title: $title}';
  }
}
