class UserModel {
  UserModel({required this.uid});

  final String uid;
}

class ExtendedUserData {
  ExtendedUserData({
    required this.uid,
    required this.name,
    this.email,
    this.phone,
    this.address,
    this.adLine1,
    this.adLine2,
    this.city,
    this.state,
    this.pin,
  });

  final String name;
  final String uid;
  final String? email;
  final String? phone;
  final Map<String, dynamic>? address;
  final String? adLine1;
  final String? adLine2;
  final String? city;
  final String? state;
  final String? pin;
}
