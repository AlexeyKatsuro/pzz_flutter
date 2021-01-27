import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:pzz/utils/extensions/widget_extension.dart';

/// This is a widget that controls the color of the status and navigation bar, depending on the theme colors.
///
/// TODO Note: there is some issue here, [statusBarIconBrightness]  may not be applied because [AppBar.brightness] overrides it,
///  even have the AppBar located on a different Route.
class SystemUi extends StatelessWidget {
  const SystemUi({
    Key? key,
    required this.child,
    this.systemNavigationBarColor,
    this.systemNavigationBarDividerColor,
    this.systemNavigationBarIconBrightness,
    this.statusBarColor,
    this.statusBarBrightness,
    this.statusBarIconBrightness,
  }) : super(key: key);

  final Widget child;
  final Color? systemNavigationBarColor;
  final Brightness? systemNavigationBarIconBrightness;
  final Color? systemNavigationBarDividerColor;
  final Color? statusBarColor;
  final Brightness? statusBarBrightness;
  final Brightness? statusBarIconBrightness;

  @override
  Widget build(BuildContext context) {
    // This requires a minimum delay after calling the build method so that the change to the system bars is applied
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      final theme = Theme.of(context);
      if (ModalRoute.of(context)!.isCurrent) {
        final themeBrightness = theme.colorScheme.brightness;
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            systemNavigationBarDividerColor: systemNavigationBarDividerColor,
            // `systemNavigationBarIconBrightness` has no effect
            // icon color estimates to contrast with `systemNavigationBarColor` automatically
            systemNavigationBarIconBrightness: systemNavigationBarIconBrightness ?? themeBrightness.opposite,
            systemNavigationBarColor: systemNavigationBarColor ?? theme.colorScheme.background,
            statusBarColor: statusBarColor ?? theme.colorScheme.surface.withOpacity(0.5),
            statusBarBrightness: statusBarBrightness ?? theme.colorScheme.brightness,
            statusBarIconBrightness: statusBarIconBrightness ?? themeBrightness.opposite,
          ),
        );
      }
    });
    return child;
  }
}
