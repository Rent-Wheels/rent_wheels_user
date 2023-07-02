class BackendUser {
  String userId;
  String name;
  String email;
  DateTime dob;
  String phoneNumber;
  num role;
  String profilePicture;
  String placeOfResidence;
  List<String>? cars;

  BackendUser({
    this.cars,
    required this.userId,
    required this.name,
    required this.email,
    required this.dob,
    required this.phoneNumber,
    required this.role,
    required this.profilePicture,
    required this.placeOfResidence,
  });

  factory BackendUser.fromJSON(Map<String, dynamic> json) {
    return BackendUser(
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      dob: DateTime.parse(json['dob']),
      phoneNumber: json['phoneNumber'],
      role: json['role'],
      profilePicture: json['profilePicture'],
      placeOfResidence: json['placeOfResidence'],
      cars: json['cars'] == null
          ? null
          : List<String>.from(json['cars'].map((car) => car.toString())),
    );
  }
}
