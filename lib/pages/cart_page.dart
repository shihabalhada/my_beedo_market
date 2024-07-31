
import 'package:flutter/material.dart';

import '../controllers/cart_controller.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    CartStorageService cartStorageService = CartStorageService();
    return Scaffold(
        appBar: AppBar(
        title: Text('Products'),
    ),
    body: SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: cartStorageService.cartCount(),
        itemBuilder: (context,index){
          var items = cartStorageService.getItems[index];
          return ListTile(
            title: Text(items.name+''+items.id.toString()),
            subtitle: Text(items.desc),
            onTap: () {

            },
          );
        },
      ),
    ),
    );
  }
}
