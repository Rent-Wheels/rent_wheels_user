enum Endpoints {
  login(value: '/users/login'),
  registerUser(value: '/users/'),
  getRenter(value: '/renters/:renterId'),
  updateGetOrDeleteUser(value: '/users/:userId'),
  getRenterCars(value: '/renters/:renterId/cars'),
  getOrDeleteUserReservationHistory(
    value: '/users/:userId/reservations/history',
  ),
  getAvailableCars(value: '/cars/available'),
  getOrCreateReservations(value: '/reservations'),
  updateOrDeleteReservation(value: '/reservations/:reservationId/'),
  changeReservationStatus(value: '/reservations/:reservationId/status');

  const Endpoints({required this.value});

  final String value;
}
