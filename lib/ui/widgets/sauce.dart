import 'package:flutter/material.dart';
import 'package:pzz/models/sauce.dart';
import 'package:pzz/ui/widgets/counter.dart';

class SauceWidget extends StatelessWidget {
  const SauceWidget({
    Key key,
    @required this.item,
    @required this.onAddClick,
  })  : assert(item != null),
        super(key: key);

  final Sauce item;
  final VoidCallback onAddClick;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(item.photo),
            Divider(),
            Text(
              item.title,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${item.price.toStringAsFixed(2)} р.',
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 12,
                ),
                CircularButton(
                  onPressed: onAddClick,
                  child: Icon(
                    Icons.add_shopping_cart,
                    size: 21,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
