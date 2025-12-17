import 'package:flutter/material.dart';
import 'package:madbis_mobile/widgets/madbis_appbar.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:madbis_mobile/data/products/product_repository.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final Map<int, int> _quantities = {};
  final _formKey = GlobalKey<FormState>();

  // Controllers for delivery info
  final _nameController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _postcodeController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < productRepository.length; i++) {
      _quantities[i] = 1;
    }
  }

  double getTotal() {
    double total = 0;
    for (int i = 0; i < productRepository.length; i++) {
      final priceString =
          productRepository[i]['price']?.replaceAll(RegExp(r'[^0-9.]'), '') ??
          '0';
      total += (double.tryParse(priceString) ?? 0) * (_quantities[i] ?? 1);
    }
    return total;
  }

  void _slideToOrder() {
    if (_formKey.currentState!.validate()) {
      // Place order logic here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order placed successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MadbisAppBar(title: 'Checkout'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cart summary
            Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    // Cart items
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: productRepository.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 5),
                      itemBuilder: (context, index) {
                        final product = productRepository[index];
                        final quantity = _quantities[index] ?? 1;
                        final priceString =
                            product['price']?.replaceAll(
                              RegExp(r'[^0-9.]'),
                              '',
                            ) ??
                            '0';
                        final totalPrice =
                            (double.tryParse(priceString) ?? 0) * quantity;

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '${product['name']} x$quantity',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            Text(
                              '£${totalPrice.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ],
                        );
                      },
                    ),

                    const Divider(
                      thickness: 1,
                      height: 0, // vertical spacing
                    ),

                    SizedBox(height: 5),

                    // Total
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '£${getTotal().toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Delivery Section
            Text(
              'Delivery Information',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 15),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Full Name
                  TextFormField(
                    controller: _nameController,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      labelStyle: Theme.of(context).textTheme.bodyMedium,
                      border: const OutlineInputBorder(),
                    ),
                    validator: (val) =>
                        val == null || val.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 20),

                  // Street Address
                  TextFormField(
                    controller: _streetController,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      labelText: 'Street Address',
                      labelStyle: Theme.of(context).textTheme.bodyMedium,
                      border: const OutlineInputBorder(),
                    ),
                    validator: (val) =>
                        val == null || val.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 20),

                  // City & Post Code in a row
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _cityController,
                          style: Theme.of(context).textTheme.bodyMedium,
                          decoration: InputDecoration(
                            labelText: 'City',
                            labelStyle: Theme.of(context).textTheme.bodyMedium,
                            border: const OutlineInputBorder(),
                          ),
                          validator: (val) =>
                              val == null || val.isEmpty ? 'Required' : null,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          controller: _postcodeController,
                          style: Theme.of(context).textTheme.bodyMedium,
                          decoration: InputDecoration(
                            labelText: 'Post Code',
                            labelStyle: Theme.of(context).textTheme.bodyMedium,
                            border: const OutlineInputBorder(),
                          ),
                          validator: (val) =>
                              val == null || val.isEmpty ? 'Required' : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Phone Number
                  TextFormField(
                    controller: _phoneController,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      labelStyle: Theme.of(context).textTheme.bodyMedium,
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (val) =>
                        val == null || val.isEmpty ? 'Required' : null,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Slide to order button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SlideAction(
                onSubmit: () async {
                  _slideToOrder(); // call your void function
                }, // your callback when slide completes
                text: 'Slide to Order',
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                  fontSize: 18,
                ),
                outerColor: Colors.deepPurple,
                innerColor: Colors.white, // color of the sliding thumb
                borderRadius: 50,
                sliderRotate: false, // prevents thumb rotation
                elevation: 2,
                height: 60,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
