import 'package:flutter/material.dart';
import 'package:pzz/models/sauce.dart';
import 'package:pzz/ui/widgets/counter.dart';

class SauceWidget extends StatelessWidget {
  const SauceWidget({
    Key key,
    @required this.item,
    @required this.onAddClick,
    @required this.onRemoveClick,
    @required this.isFree,
    @required this.count,
  })  : assert(item != null),
        super(key: key);

  final Sauce item;
  final VoidCallback onAddClick;
  final VoidCallback onRemoveClick;
  final bool isFree;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(item.photo),
              backgroundColor: Colors.transparent,
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: Theme.of(context).textTheme.headline6.copyWith(color: Theme.of(context).primaryColor),
                  ),
                  Text(
                    isFree ? '0.00 р' : item.priceText,
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                        ),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Counter(
              count: count,
              onRemoveClick: count > 0 ? onRemoveClick : null,
              onAddClick: onAddClick,
            )
          ],
        ),
      ),
    );
  }
}
