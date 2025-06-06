final class User {
  final String name;
  final String email;
  final DateTime dateOfBirth;
  final bool status;
  final String photoPath;

  User(
      {required this.name,
      required this.email,
      required this.dateOfBirth,
      required this.status,
      required this.photoPath});
}
