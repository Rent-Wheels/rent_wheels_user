import 'package:rent_wheels/core/models/cars/cars_model.dart';

abstract class RentWheelsCarsEndpoint {
  Stream<List<Car>> getAllAvailableCars();
}
