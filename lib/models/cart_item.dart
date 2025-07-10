import 'product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  static List<CartItem> cart = [];

  static void addToCart(Product product) {
    final existing = cart.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );

    if (existing.quantity > 0) {
      existing.quantity += 1;
    } else {
      cart.add(CartItem(product: product));
    }
  }

  static void clearCart() {
    cart.clear();
  }

  static double get total => cart.fold(
      0, (sum, item) => sum + (item.product.price * item.quantity));
}