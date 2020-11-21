import 'package:flutter/material.dart';
import 'package:pzz/res/strings.dart';

class ErrorView extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRepeatClick;

  const ErrorView({Key key, this.errorMessage, this.onRepeatClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(errorMessage, style: Theme.of(context).textTheme.subtitle1),
            SizedBox(height: 8),
            ElevatedButton.icon(
              icon: Icon(Icons.replay_rounded),
              label: Text(StringRes.repeat),
              onPressed: onRepeatClick,
            )
          ],
        ),
      ),
    );
  }
}
