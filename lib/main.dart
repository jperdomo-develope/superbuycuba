import 'package:flutter/material.dart';
import 'config.dart';
import 'screens/home_screen.dart';
import 'screens/product_details.dart';
import 'screens/cart_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/admin_panel.dart';
import 'models/product.dart';
import 'services/auth_service.dart';

void main() {
  runApp(SuperBuyCubaApp());
}

class SuperBuyCubaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super Buy Cuba',
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/cart': (context) => const CartScreen(),
        '/checkout': (context) => const CheckoutScreen(),
        '/admin': (context) => const AdminPanel(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/details') {
          final product = settings.arguments as Product;
          return MaterialPageRoute(
            builder: (context) => ProductDetails(product: product),
          );
        }
        return null;
      },
    );
  }
}