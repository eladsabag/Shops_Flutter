import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/cart";

  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                      'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 10,),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Chip(
                        label: Text(
                            '\$${cart.totalAmount.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Theme.of(context).primaryTextTheme.headline6?.color,
                            ),
                        ),
                        backgroundColor: Colors.purple,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Provider.of<Orders>(context, listen: false).addOrder(cart.items.values.toList(), cart.totalAmount);
                        cart.clear();
                      },
                      child: Text(
                          'Order Now',
                          style: TextStyle(
                            color: Theme.of(context).primaryTextTheme.headline6?.color
                          ),
                      ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10,),
          Expanded(
              child: ListView.builder(
                  itemBuilder: (ctx, i) => CartItem(
                      id: cart.items.values.toList()[i].id,
                      productId: cart.items.keys.toList()[i],
                      price: cart.items.values.toList()[i].price,
                      quantity: cart.items.values.toList()[i].quantity,
                      title: cart.items.values.toList()[i].title
                  ),
                  itemCount: cart.items.length,
              ),
          )
        ],
      ),
    );
  }
}
