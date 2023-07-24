class Profile {
  Profile({
    required this.id,
    required this.username,
    required this.updatedAt,
    required this.avatarUrl,
  });

  final String id;
  final String username;
  final String avatarUrl;
  final DateTime updatedAt;

  Profile.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        username = map['username'],
        updatedAt = DateTime.parse(map['updated_at']),
        avatarUrl = map['avatar_url'];
}
