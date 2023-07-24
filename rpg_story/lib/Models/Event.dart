import 'package:rpg_story/Utils/EventsUtils.dart';

class Event {
  String id;
  String title;
  String? description;
  DateTime date;
  EventCategory category;

  Event({
    required this.id,
    required this.title,
    this.description,
    required this.date,
    required this.category,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      category: getCategoryFromUUID(json['category']),
    );
  }
  Map<String, dynamic> eventToJson(Event event) {
    return {
      'id': event.id,
      'title': event.title,
      'description': event.description,
      'category': getUUIDFromCategory(event.category),
      'date': event.date.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Event(id: $id, title: $title, description: $description, date: $date)';
  }
}
