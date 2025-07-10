import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/product.dart';
import '../models/user.dart';
import '../models/cart_item.dart';

class WooCommerceService {
  static const String baseUrl = 'https://superbuycuba.com/wp-json/wc/v3/';
  static const String consumerKey = 'ck_7cc8b6abd58c7c681251ff8ccc0d970d51e2f854';
  static const String consumerSecret = 'cs_d97008ec114a88e53919ab20b3ed1c16f4d0a66b';

  static Uri buildUrl(String endpoint, [Map<String, String>? params]) {
    final fullParams = {
      'consumer_key': consumerKey,
      'consumer_secret': consumerSecret,
      ...?params,
    };
    return Uri.parse('$baseUrl$endpoint').replace(queryParameters: fullParams);
  }

  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(buildUrl('products'));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Error al obtener productos');
    }
  }

  static Future<int> createCustomer(AppUser user) async {
    final url = buildUrl('customers');
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toMap()));

    if (response.statusCode == 201) {
      return jsonDecode(response.body)['id'];
    } else if (response.statusCode == 400) {
      // Si ya existe, intenta obtener el ID
      final email = user.email;
      final getUrl = buildUrl('customers', {'email': email});
      final existing = await http.get(getUrl);
      if (existing.statusCode == 200) {
        final list = jsonDecode(existing.body);
        if (list.isNotEmpty) return list[0]['id'];
      }
      throw Exception('No se pudo obtener cliente existente');
    } else {
      throw Exception('Error al crear cliente');
    }
  }

  static Future<void> createOrder(AppUser user, String paymentMethod) async {
    final customerId = await createCustomer(user);

    final orderData = {
      'payment_method': 'cod',
      'payment_method_title': 'Pago al recibir',
      'set_paid': false,
      'customer_id': customerId,
      'billing': {
        'first_name': user.name,
        'email': user.email,
        'phone': user.phone,
        'address_1': user.address,
      },
      'shipping': {
        'first_name': user.name,
        'address_1': user.address,
      },
      'line_items': CartItem.cart
          .map((item) => {
                'product_id': item.product.id,
                'quantity': item.quantity,
              })
          .toList(),
      'meta_data': [
        {'key': 'Método de pago elegido', 'value': paymentMethod}
      ]
    };

    final response = await http.post(buildUrl('orders'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(orderData));

    if (response.statusCode != 201) {
      throw Exception('Error al crear orden');
    }
  }
}