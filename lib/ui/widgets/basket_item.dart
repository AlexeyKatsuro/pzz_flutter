import 'package:flutter/material.dart';
import 'package:pzz/ui/widgets/counter.dart';

class BasketItem extends StatelessWidget {
  const BasketItem({
    required this.name,
    required this.price,
    required this.size,
    required this.count,
    required this.onAddClick,
    required this.onRemoveClick,
  });

  final String name;
  final num price;
  final String? size;
  final int count;
  final VoidCallback onAddClick;
  final VoidCallback onRemoveClick;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: theme.textTheme.headline6!.copyWith(
            color: theme.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (size != null && size!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(size!),
          ),
        Row(
          children: [
            Counter(count: count, onRemoveClick: onRemoveClick, onAddClick: onAddClick),
            Expanded(
              child: Text(
                '${(price * count).toStringAsFixed(2)} р.',
                textAlign: TextAlign.right,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold),
              ),
            )
          ],
        )
      ],
    );
  }
}
