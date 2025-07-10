import '../models/user.dart';
import 'woocommerce_service.dart';

class AuthService {
  static Future<int> loginOrRegister(AppUser user) async {
    return await WooCommerceService.createCustomer(user);
  }
}