import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class DialogRoute<T> extends PopupRoute<T> {
  DialogRoute({
    required WidgetBuilder builder,
    bool barrierDismissible = true,
    String? barrierLabel,
    Color? barrierColor = Colors.black45,
    Duration? transitionDuration = const Duration(milliseconds: 200),
    RouteTransitionsBuilder? transitionBuilder = buildMaterialDialogTransitions,
    bool? useSafeArea = true,
    ui.ImageFilter? filter,
    RouteSettings? settings,
  })  : _builder = builder,
        _useSafeArea = useSafeArea,
        _barrierDismissible = barrierDismissible,
        _barrierLabel = barrierLabel,
        _barrierColor = barrierColor,
        _transitionDuration = transitionDuration,
        _transitionBuilder = transitionBuilder,
        super(
          settings: settings,
          filter: filter,
        );

  factory DialogRoute.withStyle({
    required WidgetBuilder builder,
    RouteSettings? settings,
    DialogRouteStyle? style,
  }) {
    final defaultStyle = DialogRouteStyle(
      barrierDismissible: true,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: buildMaterialDialogTransitions,
      useSafeArea: true,
      //filter: ui.ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
    );
    final effectiveStyle = defaultStyle.fill(style);
    return DialogRoute(
      builder: builder,
      barrierDismissible: effectiveStyle.barrierDismissible!,
      barrierLabel: effectiveStyle.barrierLabel,
      barrierColor: effectiveStyle.barrierColor,
      transitionDuration: effectiveStyle.transitionDuration,
      transitionBuilder: effectiveStyle.transitionBuilder,
      useSafeArea: effectiveStyle.useSafeArea,
      filter: effectiveStyle.filter,
      settings: settings,
    );
  }

  final WidgetBuilder _builder;
  final bool? _useSafeArea;

  @override
  bool get barrierDismissible => _barrierDismissible;
  final bool _barrierDismissible;

  @override
  String? get barrierLabel => _barrierLabel;
  final String? _barrierLabel;

  @override
  Color? get barrierColor => _barrierColor;
  final Color? _barrierColor;

  @override
  Duration get transitionDuration => _transitionDuration!;
  final Duration? _transitionDuration;

  final RouteTransitionsBuilder? _transitionBuilder;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return Semantics(
      scopesRoute: true,
      explicitChildNodes: true,
      child: buildContent(context),
    );
  }

  Widget buildContent(BuildContext context) {
    Widget dialog = Builder(builder: _builder);
    if (_useSafeArea!) {
      dialog = SafeArea(child: dialog);
    }
    // Fix for https://github.com/flutter/flutter/issues/12722
    // Not allow close dialog with barrierDismissible = false by BackPress on Android
    if (!barrierDismissible) {
      dialog = WillPopScope(
        onWillPop: () async => false,
        child: dialog,
      );
    }
    return dialog;
  }

  @override
  Widget buildTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    if (_transitionBuilder == null) {
      return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.linear,
          ),
          child: child);
    } // Some default transition
    return _transitionBuilder!(context, animation, secondaryAnimation, child);
  }

  static Widget buildMaterialDialogTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: child,
    );
  }
}

class MaterialDialogPage<T> extends Page<T> {
  const MaterialDialogPage({
    required this.child,
    String? name,
    Object? arguments,
    LocalKey? key,
    String? restorationId,
    this.style,
  }) : super(
          name: name,
          arguments: arguments,
          key: key,
          restorationId: restorationId,
        );

  final Widget child;
  final DialogRouteStyle? style;

  @override
  Route<T> createRoute(BuildContext context) {
    return DialogRoute.withStyle(
      builder: (context) => child,
      style: style,
      settings: this,
    );
  }
}

class DialogRouteStyle {
  DialogRouteStyle({
    this.barrierDismissible,
    this.barrierLabel,
    this.barrierColor,
    this.transitionDuration,
    this.transitionBuilder,
    this.useSafeArea,
    this.filter,
    this.settings,
  });

  final bool? barrierDismissible;
  final String? barrierLabel;
  final Color? barrierColor;
  final Duration? transitionDuration;
  final RouteTransitionsBuilder? transitionBuilder;
  final bool? useSafeArea;
  final ui.ImageFilter? filter;
  final RouteSettings? settings;

  /// Returns a copy of DialogRouteStyle where the null fields in [other]
  /// have replaced the corresponding non-null fields from this ButtonStyle.
  ///
  /// In other words, this DialogRouteStyle is used to fill in unspecified (null) fields
  /// in [other].
  DialogRouteStyle fill(DialogRouteStyle? other) {
    if (other == null) return this;
    return other.merge(this);
  }

  /// Returns a copy of this DialogRouteStyle where the non-null fields in [style]
  /// have replaced the corresponding null fields in this ButtonStyle.
  ///
  /// In other words, [style] is used to fill in unspecified (null) fields
  /// this DialogRouteStyle.
  DialogRouteStyle merge(DialogRouteStyle? style) {
    if (style == null) return this;
    return DialogRouteStyle(
      barrierDismissible: barrierDismissible ?? style.barrierDismissible,
      barrierLabel: barrierLabel ?? style.barrierLabel,
      barrierColor: barrierColor ?? style.barrierColor,
      transitionDuration: transitionDuration ?? style.transitionDuration,
      transitionBuilder: transitionBuilder ?? style.transitionBuilder,
      useSafeArea: useSafeArea ?? style.useSafeArea,
      filter: filter ?? style.filter,
    );
  }

  DialogRouteStyle copyWith({
    bool? barrierDismissible,
    String? barrierLabel,
    Color? barrierColor,
    Duration? transitionDuration,
    RouteTransitionsBuilder? transitionBuilder,
    bool? useSafeArea,
    ui.ImageFilter? filter,
  }) {
    return DialogRouteStyle(
      barrierDismissible: barrierDismissible ?? this.barrierDismissible,
      barrierLabel: barrierLabel ?? this.barrierLabel,
      barrierColor: barrierColor ?? this.barrierColor,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionBuilder: transitionBuilder ?? this.transitionBuilder,
      useSafeArea: useSafeArea ?? this.useSafeArea,
      filter: filter ?? this.filter,
    );
  }
}
