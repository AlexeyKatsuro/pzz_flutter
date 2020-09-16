import 'package:flutter/foundation.dart';

@immutable
class House {
  final int id;
  final String title;

  const House({this.id, this.title});

  @override
  String toString() {
    return 'Street{id: $id, title: $title}';
  }
}
