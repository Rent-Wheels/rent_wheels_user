enum Endpoints {
  login(value: '/users/login'),
  registerUser(value: '/users/'),
  updateUser(value: '/users/:userId'),
  deleteUser(value: '/users/:userId');

  const Endpoints({required this.value});

  final String value;
}
