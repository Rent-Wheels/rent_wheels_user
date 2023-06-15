class Car {
  String? carId;
  String owner;
  String make;
  String model;
  num capacity;
  String yearOfManufacture;
  String registrationNumber;
  String condition;
  num rate;
  String plan;
  String type;
  bool availability;
  String location;
  num maxDuration;
  String description;
  String terms;
  List<Media> media;

  Car({
    this.carId,
    required this.owner,
    required this.make,
    required this.model,
    required this.capacity,
    required this.yearOfManufacture,
    required this.registrationNumber,
    required this.condition,
    required this.rate,
    required this.plan,
    required this.type,
    required this.availability,
    required this.location,
    required this.maxDuration,
    required this.description,
    required this.terms,
    required this.media,
  });

  factory Car.fromJSON(Map<String, dynamic> json) {
    return Car(
      carId: json['carId'],
      owner: json['owner'],
      make: json['make'],
      model: json['model'],
      capacity: json['capacity'],
      yearOfManufacture: json['yearOfManufacture'],
      registrationNumber: json['registrationNumber'],
      condition: json['condition'],
      rate: json['rate'],
      plan: json['plan'],
      type: json['type'],
      availability: json['availability'],
      location: json['location'],
      maxDuration: json['maxDuration'],
      description: json['description'],
      terms: json['terms'],
      media: List<Media>.from(
        json['media'].map((media) => Media.fromJSON(media)),
      ),
    );
  }
}

class Media {
  String mediaURL;

  Media({required this.mediaURL});

  factory Media.fromJSON(Map<String, dynamic> json) {
    return Media(mediaURL: json['mediaURL']);
  }
}
