import 'package:flutter/cupertino.dart';

@immutable
class Street {
  const Street({required this.id, required this.title});

  final int id;
  final String title;

  @override
  String toString() {
    return 'Street{id: $id, title: $title}';
  }
}
