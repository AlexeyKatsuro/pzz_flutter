import 'package:flutter/material.dart';

class BadgeCounter extends StatelessWidget {
  final int count;
  final Widget child;

  const BadgeCounter({this.count, this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      alignment: Alignment.topRight,
      fit: StackFit.loose,
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: -6,
          right: -6,
          child: Container(
            height: 24,
            width: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: theme.colorScheme.primary, shape: BoxShape.circle),
            child: Text(
              '$count',
              maxLines: 1,
              style: theme.textTheme.bodyText1.copyWith(
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),
        )
      ],
    );
  }
}
