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
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6.copyWith(color: Theme.of(context).primaryColor),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${item.price.toStringAsFixed(2)} р.',
                      style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                          ),
                    ),
                  ],
                )
              ],
            ),
            Spacer(),
            CircularButton(
              onPressed: onAddClick,
              child: Icon(
                Icons.add_shopping_cart,
                size: 21,
              ),
            )
          ],
        ),
      ),
    );
  }
}
