import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({Key? key, required this.errorMessage, this.onRepeatClick}) : super(key: key);

  final String errorMessage;
  final VoidCallback? onRepeatClick;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              errorMessage,
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              icon: const Icon(Icons.replay_rounded),
              label: Text(localizations.repeat),
              onPressed: onRepeatClick,
            )
          ],
        ),
      ),
    );
  }
}
