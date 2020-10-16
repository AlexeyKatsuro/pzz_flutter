import 'package:flutter/cupertino.dart';

@immutable
class Street {
  final int id;
  final String title;

  const Street({this.id, this.title});

  @override
  String toString() {
    return 'Street{id: $id, title: $title}';
  }
}
