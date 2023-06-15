import 'package:rent_wheels/core/models/cars/cars_model.dart';

abstract class RentWheelsCarsEndpoint {
  Future<List<Car>> getAllAvailableCars();
}
