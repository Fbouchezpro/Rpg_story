import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:rpg_story/Bloc/Event_bloc/event_repository.dart';

import 'package:rpg_story/Models/Event.dart';
import 'package:rpg_story/Utils/EventsUtils.dart';
import 'package:uuid/uuid.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBlocBloc extends Bloc<EventBlocEvent, EventBlocState> {
  final uuid = const Uuid();

  final EventBlocRepository eventBlocRepository;
  EventBlocBloc({required this.eventBlocRepository})
      : super(EventBlocInitial()) {
    on<RequestingListEvents>(_onRequestingListEvents);
    on<CreateEvent>(_onCreateEvent);
  }

  FutureOr<void> _onRequestingListEvents(
      RequestingListEvents event, Emitter<EventBlocState> emit) async {
    emit(ListEventsLoading());
    try {
      List<Event> eventsList = await eventBlocRepository.getAllEvents();
      emit(ListEventsDone(listEvents: eventsList));
    } catch (error) {
      emit(ListEventsFailure(error: Error()));
    }
  }

  FutureOr<void> _onCreateEvent(
      CreateEvent event, Emitter<EventBlocState> emit) async {
    emit(CreateEventLoading());
    try {
      Event newEvent = Event(
          id: uuid.v4().toString(),
          title: event.title,
          description: event.description,
          date: event.date,
          category: event.category);
      eventBlocRepository.addEvent(newEvent);
      emit(CreateEventDone(newEvent: newEvent));
    } catch (error) {
      emit(ListEventsFailure(error: Error()));
    }
  }
}
