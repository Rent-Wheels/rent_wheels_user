import 'package:equatable/equatable.dart';

class CarMedia extends Equatable {
  final String? id, mediaURL;

  const CarMedia({
    required this.id,
    required this.mediaURL,
  });

  @override
  List<Object?> get props => [
        id,
        mediaURL,
      ];

  Map<String, dynamic> toMap() => {
        'id': id,
        'mediaURL': mediaURL,
      };
}
