import 'package:pzz/models/navigation_stack.dart';

abstract class NavigateAction {
  NavigateAction();

  factory NavigateAction.push(String name, {Object? arguments}) => NavigatePushAction(name, arguments: arguments);

  factory NavigateAction.pop() => NavigatePopAction();
}

class NavigatePushAction extends NavigateAction {
  NavigatePushAction(this.name, {this.arguments});

  final String name;

  final Object? arguments;
}

class NavigatePopAction extends NavigateAction {}

class NavigationStackChangedAction {
  NavigationStackChangedAction({required this.prevStack, required this.newStack});

  final NavigationStack prevStack;
  final NavigationStack newStack;
}
