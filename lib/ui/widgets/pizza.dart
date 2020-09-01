import 'package:flutter/material.dart';
import 'package:pzz/models/pizza.dart';
import 'package:pzz/ui/widgets/pizza_variant.dart';

class PizzaWidget extends StatelessWidget {
  final Pizza pizza;
  final void Function(Pizza, PizzaSize) onAddPizzaClick;

  const PizzaWidget({
    @required this.pizza,
    @required this.onAddPizzaClick,
  })  : assert(pizza != null),
        assert(onAddPizzaClick != null);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            pizza.photo,
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Divider(
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text(
                  pizza.name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                ),
                ListView.separated(
                  physics: ClampingScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => PizzaVariantWidget(
                    variant: pizza.variants[index],
                    onAddPizzaClick: (size) {
                      onAddPizzaClick(pizza, size);
                    },
                  ),
                  separatorBuilder: (context, index) => Divider(height: 12),
                  itemCount: pizza.variants.length,
                ),
                Text(
                  pizza.description,
                  style: Theme.of(context).textTheme.bodyText2,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
