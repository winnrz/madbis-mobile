import 'package:flutter/material.dart';
import 'package:madbis_mobile/screens/home_screen.dart';
import 'package:madbis_mobile/screens/cart_screen.dart';
import 'package:madbis_mobile/screens/product_detail_screen.dart';

void main() {
  runApp(const MadbisMobile());
}

class MadbisMobile extends StatelessWidget {
  const MadbisMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Madbis Mobile',

      // Global Theme
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 244, 244, 244),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          elevation: 4,
          centerTitle: true,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.deepPurple,
        ),
        textTheme: const TextTheme(
          bodySmall: TextStyle(fontSize: 16, color: Colors.black87),
          bodyMedium: TextStyle(fontSize: 18, color: Colors.black87),
          bodyLarge: TextStyle(fontSize: 24, color: Colors.black87),
        ),
      ),

      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/cart': (context) => const CartScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/product' && settings.arguments != null) {
          final product = settings.arguments as Map<String, String>;
          return MaterialPageRoute(
            builder: (_) => ProductDetailScreen(product: product),
            settings: settings,
          );
        }
        return null;
      },
    );
  }
}
