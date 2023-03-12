import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product_screen.dart';
import '../providers/products.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const UserProductItem({Key? key, required this.title, required this.imageUrl, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);

    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
                onPressed: () async {
                  Navigator.of(context).pushNamed(EditProductScreen.routeName, arguments: id);
                },
                icon: const Icon(Icons.edit),
                color: Colors.purple,
            ),
            IconButton(
                onPressed: () async {
                  try {
                    await Provider.of<Products>(context, listen: false).deleteProduct(id);
                  } catch(error) {
                    scaffold.showSnackBar(const SnackBar(content: Text('Deleting failed!', textAlign: TextAlign.center,)));
                  }
                },
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor
            )
          ],
        ),
      ),
    );
  }
}
