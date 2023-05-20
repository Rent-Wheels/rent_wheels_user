//login exceptions
class UserNotFoundAuthException implements Exception {}

class InvalidPasswordAuthException implements Exception {}

//registration exceptions
class WeakPasswordAuthException implements Exception {}

class InvalidEmailException implements Exception {}

//generic exceptions
class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}
