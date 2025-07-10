import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart_item.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(product.image, height: 250, width: double.infinity, fit: BoxFit.cover),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(product.description, style: const TextStyle(fontSize: 16)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('\$${product.price}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                CartItem.addToCart(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Producto agregado al carrito")),
                );
              },
              child: const Text('Agregar al carrito'),
            ),
          ),
        ],
      ),
    );
  }
}