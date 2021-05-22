import 'package:flutter/material.dart';
import 'package:pzz/res/constants.dart';

class LoadingSwitcher extends StatelessWidget {
  const LoadingSwitcher({
    Key? key,
    required this.isLoading,
    this.duration,
    this.loaderColor,
    required this.child,
  }) : super(key: key);

  final bool isLoading;
  final Duration? duration;
  final Color? loaderColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration ?? kDurationFast,
      child: isLoading
          ? SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(loaderColor ?? Theme.of(context).colorScheme.onPrimary),
              ))
          : child,
    );
  }
}
