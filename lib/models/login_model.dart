class LoginModel {
  final int success;
  final String message;
  final CustomerData? customerData;
  final String? guestId;

  LoginModel({required this.success, required this.message, this.customerData, this.guestId});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      success: json['success'],
      message: json['message'],
      customerData: json['customerdata'] != null
          ? CustomerData.fromJson(json['customerdata'])
          : null,
      guestId: json['guest_id'],
    );
  }
}

class CustomerData {
  final String id;
  final String name;
  final String email;
  final String mobile;
  final String token;

  CustomerData({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.token,
  });

  factory CustomerData.fromJson(Map<String, dynamic> json) {
    return CustomerData(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      mobile: json['mobile'],
      token: json['token'],
    );
  }
}
