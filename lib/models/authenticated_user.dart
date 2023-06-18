class AuthenticatedUser {
  final String description;
  final String id;
  final String name;
  final String profileImageUrl;

  AuthenticatedUser({
    required this.description,
    required this.id,
    required this.name,
    required this.profileImageUrl,
  });

  factory AuthenticatedUser.fromJson(Map<String, dynamic> json) {
    return AuthenticatedUser(
      description: json['description'],
      id: json['id'],
      name: json['name'],
      profileImageUrl: json['profile_image_url'],
    );
  }
}
