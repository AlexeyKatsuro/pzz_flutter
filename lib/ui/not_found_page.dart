import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                localizations.error404,
                style: theme.textTheme.headline2.copyWith(color: theme.colorScheme.secondary),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Text(
                localizations.error404Message,
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
