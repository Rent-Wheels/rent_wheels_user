enum Roles {
  user(id: 3921),
  admin(id: 9291),
  renter(id: 6631);

  const Roles({required this.id});

  final int id;
}
