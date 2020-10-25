import 'package:flutter/material.dart';

extension ListWidgetExt on List<Widget> {
  List<Widget> divideChildren({
    @required Widget divider,
    bool surround = false,
  }) {
    final children = this;
    if (children == null || children.isEmpty) return [];
    if (divider == null) return children;

    final listBuilder = <Widget>[];
    if (surround) listBuilder.add(divider);
    for (int index = 0; index < children.length; index++) {
      listBuilder.add(children[index]);
      if (surround || index != children.length - 1) {
        listBuilder.add(divider);
      }
    }
    return listBuilder;
  }
}
