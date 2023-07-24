part of 'event_bloc.dart';

abstract class EventBlocEvent {}

class RequestingListEvents extends EventBlocEvent {
  RequestingListEvents();
}

class CreateEvent extends EventBlocEvent {
  final String id;
  final String title;
  final String? description;
  final DateTime date;
  final EventCategory category;

  CreateEvent({
    required this.id,
    required this.title,
    this.description,
    required this.date,
    required this.category,
  });
}
