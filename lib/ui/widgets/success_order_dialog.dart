import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:pzz/ui/widgets/bottom_sheet_drag_bar.dart';

class SuccessOrderDialog extends StatelessWidget {
  const SuccessOrderDialog({Key? key, required this.freeAfterMinute}) : super(key: key);
  final int freeAfterMinute;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Container(
      constraints: const BoxConstraints(
        minHeight: 250,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const BottomSheetDragBar(),
          const SizedBox(
            height: 12,
          ),
          Text(
            localizations.thankForOrder,
            style: theme.textTheme.headline6,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            localizations.deliveryConditions(freeAfterMinute.toString()),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(localizations.toMenu),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
