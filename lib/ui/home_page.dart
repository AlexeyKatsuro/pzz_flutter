import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pzz/models/app_state.dart';
import 'package:pzz/models/pizza.dart';
import 'package:redux/redux.dart';
import 'package:pzz/models/pizza_variant.dart';
import 'package:pzz/res/strings.dart';
import 'package:pzz/utils/extensions/enum_localization_ext.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onInit;

  HomePage({@required this.onInit}) : assert(onInit != null);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.formStore,
      builder: (context, vm) {
        return Scaffold(
          appBar: AppBar(
            title: Text(StringRes.appName),
          ),
          body: vm.loading ? _buildLoader() : _buildPizzasList(vm.pizzas),
        );
      },
    );
  }

  Widget _buildPizzasList(List<Pizza> pizzas) {
    return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemBuilder: (context, index) => PizzaItem(pizzas[index]),
        separatorBuilder: (context, index) => SizedBox(height: 8),
        itemCount: pizzas.length);
  }

  Widget _buildLoader() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _ViewModel {
  final List<Pizza> pizzas;
  final bool loading;

  _ViewModel({this.pizzas, this.loading});

  static _ViewModel formStore(Store<AppState> store) {
    return _ViewModel(pizzas: store.state.pizzas, loading: store.state.isLoading);
  }
}

class PizzaItem extends StatelessWidget {
  final Pizza pizza;

  const PizzaItem(this.pizza);

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
                  itemBuilder: (context, index) => PizzaVariantWidget(pizza.variants[index]),
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

class PizzaVariantWidget extends StatelessWidget {
  final PizzaVariant variant;

  const PizzaVariantWidget(this.variant);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                variant.size.localizedString,
              ),
              Text(
                '${variant.price.toStringAsFixed(2)} р.',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold),
              ),
              Text(
                '${variant.weight} ${variant.diameter}',
              ),
            ],
          ),
        ),
        Expanded(
          child: OutlineButton(
            textColor: Theme.of(context).colorScheme.primary,
            onPressed: () {},
            child: Text(StringRes.in_basket),
          ),
        )
      ],
    );
  }
}
