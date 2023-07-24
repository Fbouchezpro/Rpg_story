class Discussion {
  final String id;
  final DateTime createdDate;
  final String title;
  final List<String> discussionUsers;

  Discussion({
    required this.id,
    required this.createdDate,
    required this.title,
    required this.discussionUsers,
  });

  factory Discussion.fromJson(Map<String, dynamic> json) {
    return Discussion(
      id: json['id'],
      createdDate: DateTime.parse(json['created_at']),
      title: json['title'],
      discussionUsers: (json['users'] as List<dynamic>).cast<String>(),
    );
  }

  Map<String, dynamic> discussionToJson(Discussion discussion) {
    return {
      'id': discussion.id,
      'title': discussion.title,
      'date': discussion.createdDate,
      'users': discussion.discussionUsers,
    };
  }
}
