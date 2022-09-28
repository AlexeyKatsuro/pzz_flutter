import 'package:pzz/models/navigation/navigation_stack.dart';

abstract class NavigateAction {
  NavigateAction();

  factory NavigateAction.push(String name, {Object? arguments}) =>
      NavigatePushAction(name, arguments: arguments);

  factory NavigateAction.replace(String name, {Object? arguments}) =>
      NavigateReplaceAction(name, arguments: arguments);

  factory NavigateAction.pop() => NavigatePopAction();

  factory NavigateAction.popUntil(String page, {bool inclusive = false}) =>
      NavigatePopUntilAction(page, inclusive: inclusive);

  factory NavigateAction.pushAndRemoveUntil(
    String page, {
    String? untilPage,
    bool inclusive = false,
    Object? arguments,
  }) =>
      NavigatePushAndRemoveUntilAction(
        page,
        removeUntilPage: untilPage,
        inclusive: inclusive,
        arguments: arguments,
      );
}

class NavigatePushAction extends NavigateAction {
  NavigatePushAction(this.name, {this.arguments});

  final String name;

  final Object? arguments;
}

class NavigateReplaceAction extends NavigateAction {
  NavigateReplaceAction(this.name, {this.arguments});

  final String name;

  final Object? arguments;
}

class NavigatePopAction extends NavigateAction {}

class NavigatePopUntilAction extends NavigateAction {
  NavigatePopUntilAction(
    this.name, {
    this.inclusive = false,
  });

  final String name;
  final bool inclusive;
}

class NavigatePushAndRemoveUntilAction extends NavigateAction {
  NavigatePushAndRemoveUntilAction(
    this.name, {
    this.removeUntilPage,
    this.inclusive = false,
    this.arguments,
  });

  String name;
  String? removeUntilPage;
  bool inclusive = false;
  Object? arguments;
}

class NavigationStackChangedAction {
  NavigationStackChangedAction({required this.prevStack, required this.newStack});

  final NavigationStack prevStack;
  final NavigationStack newStack;
}
