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

extension ButtonStyleExt on ButtonStyle {
  /// Returns a copy of ButtonStyle where the null fields in [other]
  /// have replaced the corresponding non-null fields in this ButtonStyle.
  ///
  /// In other words, this ButtonStyle is used to fill in unspecified (null) fields
  /// in [other].
  ButtonStyle fill(ButtonStyle other) {
    if (other == null) return this;
    return other.merge(this);
  }
}
