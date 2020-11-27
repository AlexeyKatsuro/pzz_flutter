import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

/// This is a widget that controls the color of the status and navigation bar, depending on the theme colors.
class StatusBarBrightness extends StatelessWidget {
  final Widget child;

  const StatusBarBrightness({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // This requires a minimum delay after calling the build method so that the change to the status bar is applied
      final theme = Theme.of(context);
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          systemNavigationBarColor: theme.colorScheme.background,
          statusBarColor: theme.colorScheme.surface.withOpacity(0.5),
        ),
      );
    });
    return child;
  }
}
