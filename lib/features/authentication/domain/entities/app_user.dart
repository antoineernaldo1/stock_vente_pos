class AppUser {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final String role;
  final DateTime createdAt;

  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    required this.role,
    required this.createdAt,
  });
}
