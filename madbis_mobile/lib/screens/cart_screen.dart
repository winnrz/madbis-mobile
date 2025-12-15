import 'package:flutter/material.dart';
import 'package:madbis_mobile/widgets/madbis_appbar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MadbisAppBar(title: 'Cart', cartItemCount: 3),
      body: const Center(child: Text('Your cart is empty')),
    );
  }
}
