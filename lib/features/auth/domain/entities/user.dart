class User {
  const User({
    required this.id,
    required this.name,
    required this.email,
  });
  final String id;
  final String name;
  final String email;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email;

  @override
  int get hashCode => id.hashCode ^ email.hashCode;
}
