import 'package:rpg_story/Models/Event.dart';
import 'package:rpg_story/Utils/EventsUtils.dart';
import 'package:rpg_story/main.dart';

class EventBlocRepository {
  final List<Event> _events = [];

  Future<List<Event>> getAllEvents() async {
    final response = await supabase.from('events').select('*');
    final data = response as List<dynamic>;
    final events = data.map((eventData) => Event.fromJson(eventData)).toList();
    return events;
  }

  Future<void> addEvent(Event event) async {
    await supabase.from('events').insert({
      'id': event.id,
      "title": event.title,
      "description": event.description,
      "category": getUUIDFromCategory(event.category),
      'date': event.date.toIso8601String(),
    });
  }

  Future<void> updateEvent(Event event) async {
    final existingEvent = _events.firstWhere(
      (e) => e.id == event.id,
    );
    existingEvent.title = event.title;
    existingEvent.description = event.description;
  }

  Future<void> deleteEvent(String eventId) async {
    _events.removeWhere((event) => event.id == eventId);
  }
}
