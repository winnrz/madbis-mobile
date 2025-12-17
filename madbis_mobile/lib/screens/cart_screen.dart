import 'package:flutter/material.dart';
import 'package:madbis_mobile/widgets/madbis_appbar.dart';
import 'package:madbis_mobile/widgets/product_cart_card.dart';
import 'package:madbis_mobile/data/products/product_repository.dart';
import 'package:madbis_mobile/screens/checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final Map<int, int> _quantities = {};

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < productRepository.length; i++) {
      _quantities[i] = 1;
    }
  }

  double getSubtotal() {
    double subtotal = 0;
    for (int i = 0; i < productRepository.length; i++) {
      final priceString =
          productRepository[i]['price']?.replaceAll(RegExp(r'[^0-9.]'), '') ??
          '0';
      subtotal += (double.tryParse(priceString) ?? 0) * (_quantities[i] ?? 1);
    }
    return subtotal;
  }

  double getShipping() {
    // You can adjust shipping calculation logic here
    return 0.00;
  }

  double getTotal() {
    return getSubtotal() + getShipping();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MadbisAppBar(title: 'Cart', cartItemCount: 3),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListView.separated(
                itemCount: productRepository.length,
                separatorBuilder: (_, __) => const SizedBox(height: 3),
                itemBuilder: (context, index) {
                  final product = productRepository[index];
                  return ProductCartCard(
                    imagePath:
                        product['image'] ??
                        'assets/images/product_placeholder.png',
                    name: product['name'] ?? 'Unknown Product',
                    price: product['price'] ?? '\£0.00',
                    initialQuantity: _quantities[index] ?? 1,
                    onQuantityChanged: (qty) {
                      setState(() {
                        _quantities[index] = qty;
                      });
                    },
                  );
                },
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Subtotal
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Subtotal:',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      '\£${getSubtotal().toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // Shipping
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Shipping:',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      '\£${getShipping().toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Divider(height: 20, thickness: 1),

                // Total
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\£${getTotal().toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Checkout Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CheckoutScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Proceed to Checkout',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
