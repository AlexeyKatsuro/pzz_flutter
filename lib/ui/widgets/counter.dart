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
        SizedBox(
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
            onPressed: onRemoveClick,
            child: Text(
              '-',
              style: Theme.of(context).accentTextTheme.headline5.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            '$count',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        SizedBox(
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
            onPressed: onAddClick,
            child: Text(
              '+',
              style: Theme.of(context).accentTextTheme.headline5.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
