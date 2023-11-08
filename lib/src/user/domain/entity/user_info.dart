class UserInfo {
  String? id,
      userId,
      name,
      email,
      dob,
      phoneNumber,
      profilePicture,
      placeOfResidence;
  List<String>? cars;

  UserInfo({
    this.cars,
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.dob,
    required this.phoneNumber,
    required this.profilePicture,
    required this.placeOfResidence,
  });

  factory UserInfo.fromJSON(Map<String, dynamic> json) {
    return UserInfo(
      id: json['_id'],
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      dob: json['dob'],
      phoneNumber: json['phoneNumber'],
      profilePicture: json['profilePicture'],
      placeOfResidence: json['placeOfResidence'],
      cars: json['cars']
          .map<String>(
            (car) => car.toString(),
          )
          .toList(),
    );
  }
}
