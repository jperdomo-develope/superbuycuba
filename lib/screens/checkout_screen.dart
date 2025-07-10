import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../widgets/payment_selector.dart';
import '../services/woocommerce_service.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedPayment = "CUP";
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController addressCtrl = TextEditingController();

  void submitOrder() async {
    await WooCommerceService().createOrder(
      name: nameCtrl.text,
      email: emailCtrl.text,
      phone: phoneCtrl.text,
      address: addressCtrl.text,
      paymentMethod: selectedPayment,
      cartItems: CartItem.cart,
    );

    CartItem.clearCart();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Pedido enviado correctamente")),
    );
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "Nombre completo")),
            TextField(controller: emailCtrl, decoration: const InputDecoration(labelText: "Correo electrónico")),
            TextField(controller: phoneCtrl, decoration: const InputDecoration(labelText: "Teléfono")),
            TextField(controller: addressCtrl, decoration: const InputDecoration(labelText: "Dirección")),
            const SizedBox(height: 16),
            PaymentSelector(
              selected: selectedPayment,
              onChanged: (method) => setState(() => selectedPayment = method),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: submitOrder,
              child: const Text("Confirmar pedido"),
            ),
          ],
        ),
      ),
    );
  }
}