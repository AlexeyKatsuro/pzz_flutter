abstract class NavigateAction {
  NavigateAction();

  factory NavigateAction.push(String name, {Object arguments}) => NavigatePushAction(name, arguments: arguments);

  factory NavigateAction.pop() => NavigatePopAction();
}

class NavigatePushAction extends NavigateAction {
  final String name;
  final Object arguments;

  NavigatePushAction(this.name, {this.arguments});
}

class NavigatePopAction extends NavigateAction {}
