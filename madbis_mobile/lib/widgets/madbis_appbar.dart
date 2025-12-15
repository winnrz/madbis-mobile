import 'package:flutter/material.dart';

class MadbisAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final int cartItemCount;
  final VoidCallback? onCartPressed;

  const MadbisAppBar({
    super.key,
    required this.title,
    this.cartItemCount = 0,
    this.onCartPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Colors.white,
        ),
      ),
      actions: [
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: onCartPressed ?? () {},
            ),
            if (cartItemCount > 0)
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    '$cartItemCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  // required for PreferredSizeWidgets to allocate vertical space
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
