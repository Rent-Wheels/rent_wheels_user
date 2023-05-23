class User {
  String userId;
  String name;
  String email;
  DateTime dob;
  String phoneNumber;
  num role;
  String profilePicture;

  User({
    required this.userId,
    required this.name,
    required this.email,
    required this.dob,
    required this.phoneNumber,
    required this.role,
    required this.profilePicture,
  });

  factory User.fromJSON(Map<String, dynamic> json) {
    return User(
        userId: json['userId'],
        name: json['name'],
        email: json['email'],
        dob: json['dob'],
        phoneNumber: json['phoneNumber'],
        role: json['role'],
        profilePicture: json['profilePicture']);
  }
}
