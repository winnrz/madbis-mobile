import 'package:flutter/material.dart';
import 'package:madbis_mobile/data/products/product_repository.dart';
import 'package:madbis_mobile/widgets/madbis_appbar.dart';
import 'package:madbis_mobile/widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MadbisAppBar(
        title: 'Products',
        cartItemCount: 3,
        onCartPressed: () {
          // Only navigate if not already on the cart screen
          if (ModalRoute.of(context)?.settings.name != '/cart') {
            Navigator.pushNamed(context, '/cart');
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SafeArea(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.7,
            ),
            itemCount: productRepository.length,
            itemBuilder: (context, index) {
              final product = productRepository[index];
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/product',
                    arguments: product, 
                  );
                },
                child: ProductCard(
                  imagePath:
                      product['image'] ??
                      'assets/images/product_placeholder.png',
                  name: product['name'] ?? 'Unknown Product',
                  price: product['price'] ?? '\£0.00',
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
