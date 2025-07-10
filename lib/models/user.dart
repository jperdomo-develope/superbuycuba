class AppUser {
  final String name;
  final String email;
  final String phone;
  final String address;

  AppUser({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'first_name': name,
      'email': email,
      'billing': {
        'address_1': address,
        'phone': phone,
      },
      'shipping': {
        'address_1': address,
      }
    };
  }
}