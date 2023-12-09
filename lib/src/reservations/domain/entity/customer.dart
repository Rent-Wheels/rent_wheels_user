import 'package:equatable/equatable.dart';

class Customer extends Equatable {
  final String? id, name;

  const Customer({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
