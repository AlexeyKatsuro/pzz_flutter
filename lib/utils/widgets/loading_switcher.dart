import 'package:flutter/material.dart';
import 'package:pzz/res/constants.dart';

class LoadingSwitcher extends StatelessWidget {
  final bool isLoading;
  final Duration duration;
  final Color loaderColor;
  final Widget child;

  const LoadingSwitcher({
    Key key,
    @required this.isLoading,
    this.duration,
    this.loaderColor,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      child: isLoading
          ? SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(loaderColor ?? Theme.of(context).colorScheme.onPrimary),
              ))
          : child,
      duration: duration ?? kDurationFast,
    );
  }
}
