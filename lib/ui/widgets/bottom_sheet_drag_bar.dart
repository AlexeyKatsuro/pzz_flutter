import 'package:flutter/material.dart';

class BottomSheetDragBar extends StatelessWidget {
  const BottomSheetDragBar({Key? key, this.padding}) : super(key: key);

  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding ?? const EdgeInsets.all(8.0),
        child: Container(
          width: 32,
          height: 6,
          decoration: BoxDecoration(
            color: Theme.of(context).dividerColor,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
