import 'package:flutter/material.dart';
import 'package:pzz/res/strings.dart';

class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                StringRes.error_404,
                style: theme.textTheme.headline2.copyWith(color: theme.colorScheme.secondary),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Text(
                StringRes.error_404_message,
                style: theme.textTheme.headline6,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
