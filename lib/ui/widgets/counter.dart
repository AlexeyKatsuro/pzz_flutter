import 'package:flutter/material.dart';

class Counter extends StatelessWidget {
  const Counter({
    Key key,
    @required this.onRemoveClick,
    @required this.count,
    @required this.onAddClick,
  }) : super(key: key);

  final VoidCallback onRemoveClick;
  final int count;
  final VoidCallback onAddClick;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularButton(
          onPressed: onRemoveClick,
          child: Text(
            '-',
            style: Theme.of(context).accentTextTheme.headline6.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            '$count',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        CircularButton(
          onPressed: onAddClick,
          child: Text(
            '+',
            style: Theme.of(context).accentTextTheme.headline6.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class CircularButton extends StatelessWidget {
  const CircularButton({
    Key key,
    @required this.onPressed,
    this.child,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      height: 36,
      child: RaisedButton(
        padding: EdgeInsets.zero,
        shape: CircleBorder(),
        textColor: Theme.of(context).colorScheme.onSecondary,
        color: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        highlightElevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
