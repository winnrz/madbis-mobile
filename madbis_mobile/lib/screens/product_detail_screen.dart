import 'package:flutter/material.dart';
import 'package:madbis_mobile/widgets/product_card.dart';
import 'package:madbis_mobile/data/products/product_repository.dart';
import 'package:madbis_mobile/widgets/madbis_appbar.dart';

class ProductDetailScreen extends StatelessWidget {
  final Map<String, String> product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MadbisAppBar(
        title: product['name'] ?? 'Product',
        cartItemCount: 3,
        onCartPressed: () {
          if (ModalRoute.of(context)?.settings.name != '/cart') {
            Navigator.pushNamed(context, '/cart');
          }
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              child: Image.asset(
                product['image'] ?? 'assets/images/product_placeholder.png',
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name & Price & Description
                  Text(
                    product['name'] ?? 'Unknown Product',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    product['price'] ?? '\$0.00',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 3),
                  if (product['description'] != null)
                    Text(
                      product['description']!,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  const SizedBox(height: 16),

                  // Add to Cart Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Add to cart logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Add to Cart',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // "You May Also Like"
                  Text(
                    'You May Also Like',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3),
                  SizedBox(
                    height: 280, // height to fit ProductCard
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final suggestion = productRepository[index];
                        return GestureDetector(
                          onTap: () {
                            // Navigate to ProductDetailScreen for the tapped product
                            Navigator.pushNamed(
                              context,
                              '/product',
                              arguments: suggestion,
                            );
                          },
                          child: SizedBox(
                            width: 200,
                            child: ProductCard(
                              imagePath:
                                  suggestion['image'] ??
                                  'assets/images/product_placeholder.png',
                              name: suggestion['name'] ?? 'Unknown',
                              price: suggestion['price'] ?? '\$0.00',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
