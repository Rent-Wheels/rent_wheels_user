class Car {
  String? carId;
  String? owner;
  String? make;
  String? model;
  num? capacity;
  String? color;
  String? yearOfManufacture;
  String? registrationNumber;
  String? condition;
  num? rate;
  String? plan;
  String? type;
  bool? availability;
  String? location;
  num? maxDuration;
  String? description;
  String? terms;
  List<Media>? media;

  Car({
    this.carId,
    this.owner,
    this.make,
    this.model,
    this.capacity,
    this.color,
    this.yearOfManufacture,
    this.registrationNumber,
    this.condition,
    this.rate,
    this.plan,
    this.type,
    this.availability,
    this.location,
    this.maxDuration,
    this.description,
    this.terms,
    this.media,
  });

  factory Car.fromJSON(Map<String, dynamic> json) {
    return Car(
      carId: json['_id'],
      owner: json['owner'],
      make: json['make'],
      model: json['model'],
      capacity: json['capacity'],
      yearOfManufacture: json['yearOfManufacture'],
      color: json['color'],
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
