import 'package:flutter/material.dart';
import 'package:pzz/utils/extensions/widget_extension.dart';

class Counter extends StatelessWidget {
  const Counter({
    Key? key,
    required this.onRemoveClick,
    required this.count,
    required this.onAddClick,
  }) : super(key: key);

  final VoidCallback? onRemoveClick;
  final int? count;
  final VoidCallback onAddClick;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularButton(
          onPressed: onRemoveClick,
          child: const Text('-'),
        ),
        Text(
          '$count',
          style: Theme.of(context).textTheme.headline6,
        ),
        CircularButton(
          onPressed: onAddClick,
          child: const Text('+'),
        ),
      ],
    );
  }
}

class CircularButton extends StatelessWidget {
  const CircularButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.style,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget child;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cycleButtonStyle = ElevatedButton.styleFrom(
      primary: theme.colorScheme.secondary,
      onPrimary: theme.colorScheme.onSecondary,
      minimumSize: const Size(34, 34),
      shape: const CircleBorder(),
      padding: EdgeInsets.zero,
      elevation: 0,
    );
    // style from construction has higher priority
    final effectiveStyle = cycleButtonStyle.fill(style);
    return ElevatedButton(
      style: effectiveStyle,
      onPressed: onPressed,
      child: DefaultTextStyle.merge(child: child, style: const TextStyle(fontSize: 20)),
    );
  }
}
