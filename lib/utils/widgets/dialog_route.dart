import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class DialogRoute<T> extends PopupRoute<T> {
  DialogRoute({
    @required WidgetBuilder builder,
    bool barrierDismissible = true,
    String barrierLabel,
    Color barrierColor = Colors.black45,
    Duration transitionDuration = const Duration(milliseconds: 200),
    RouteTransitionsBuilder transitionBuilder = buildMaterialDialogTransitions,
    bool useSafeArea = true,
    ui.ImageFilter filter,
    RouteSettings settings,
  })  : assert(barrierDismissible != null),
        assert(builder != null),
        _builder = builder,
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

  factory DialogRoute.defaultExcept({
    @required WidgetBuilder builder,
    bool barrierDismissible,
    String barrierLabel,
    Color barrierColor,
    Duration transitionDuration,
    RouteTransitionsBuilder transitionBuilder,
    bool useSafeArea,
    ui.ImageFilter filter,
    RouteSettings settings,
  }) {
    return DialogRoute(
      builder: builder,
      barrierDismissible: barrierDismissible ?? true,
      barrierLabel: barrierLabel,
      barrierColor: barrierColor ?? Colors.black45,
      transitionDuration: transitionDuration ?? const Duration(milliseconds: 200),
      transitionBuilder: transitionBuilder ?? buildMaterialDialogTransitions,
      useSafeArea: useSafeArea ?? true,
      filter: filter ?? ui.ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
      settings: settings,
    );
  }

  final WidgetBuilder _builder;
  final bool _useSafeArea;

  @override
  bool get barrierDismissible => _barrierDismissible;
  final bool _barrierDismissible;

  @override
  String get barrierLabel => _barrierLabel;
  final String _barrierLabel;

  @override
  Color get barrierColor => _barrierColor;
  final Color _barrierColor;

  @override
  Duration get transitionDuration => _transitionDuration;
  final Duration _transitionDuration;

  final RouteTransitionsBuilder _transitionBuilder;

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
    if (_useSafeArea) {
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
    return _transitionBuilder(context, animation, secondaryAnimation, child);
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
  final Widget child;

  MaterialDialogPage({
    @required this.child,
    String name,
    Object arguments,
    LocalKey key,
    String restorationId,
    this.barrierDismissible,
    this.barrierLabel,
    this.barrierColor,
    this.transitionDuration,
    this.transitionBuilder,
    this.useSafeArea,
    this.filter,
    this.settings,
  }) : super(
          name: name,
          arguments: arguments,
          key: key,
          restorationId: restorationId,
        );

  final bool barrierDismissible;
  final String barrierLabel;
  final Color barrierColor;
  final Duration transitionDuration;
  final RouteTransitionsBuilder transitionBuilder;
  final bool useSafeArea;
  final ui.ImageFilter filter;
  final RouteSettings settings;

  @override
  Route<T> createRoute(BuildContext context) {
    return DialogRoute.defaultExcept(
      builder: (context) => child,
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierLabel,
      barrierColor: barrierColor,
      transitionDuration: transitionDuration,
      transitionBuilder: transitionBuilder,
      useSafeArea: useSafeArea,
      filter: filter,
      settings: this,
    );
  }
}
