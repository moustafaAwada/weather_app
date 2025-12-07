class UserModel {
  String name;
  String email;
  String password; // Note: Usually we don't store password from API, but keeping for your existing structure
  String? phone;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    this.phone,
  });

  // Factory to create User from API JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? 'User',
      email: json['email'] ?? '',
      // Password usually isn't returned by API for security. 
      // We can leave it empty or handled by the token storage.
      password: '', 
      phone: json['phone'],
    );
  }
}