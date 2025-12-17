import 'package:flutter/material.dart';

class ProductCartCard extends StatefulWidget {
  final String imagePath;
  final String name;
  final String price;
  final int initialQuantity;
  final ValueChanged<int>? onQuantityChanged;

  const ProductCartCard({
    super.key,
    this.imagePath = 'assets/images/product_placeholder.png',
    this.name = 'Product Name',
    this.price = '\£0.00',
    this.initialQuantity = 1,
    this.onQuantityChanged,
  });

  @override
  State<ProductCartCard> createState() => _ProductCartCardState();
}

class _ProductCartCardState extends State<ProductCartCard> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity;
  }

  void _increase() {
    setState(() {
      quantity++;
      widget.onQuantityChanged?.call(quantity);
    });
  }

  void _decrease() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        widget.onQuantityChanged?.call(quantity);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 110),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  widget.imagePath,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              // Product Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    Text(
                      widget.price,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          
                    ),
                  ],
                ),
              ),
              // Quantity controls
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: _decrease,
                    
                  ),
                  Text(
                    '$quantity',
                    style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: _increase,
                    
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
