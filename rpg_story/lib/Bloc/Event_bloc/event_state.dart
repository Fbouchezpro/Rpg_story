part of 'event_bloc.dart';

abstract class EventBlocState {}

class EventBlocInitial extends EventBlocState {}

class ListEventsLoading extends EventBlocState {}

class ListEventsDone extends EventBlocState {
  final List<Event> listEvents;

  ListEventsDone({required this.listEvents});
}

class ListEventsFailure extends EventBlocState {
  final Error error;

  ListEventsFailure({required this.error});

  @override
  String toString() {
    return 'ListCustomerFailure{error: $error}';
  }
}

class CreateEventLoading extends EventBlocState {}

class CreateEventDone extends EventBlocState {
  final Event newEvent;

  CreateEventDone({required this.newEvent});
}

class CreateEventFailure extends EventBlocState {
  final Error error;

  CreateEventFailure({required this.error});

  @override
  String toString() {
    return 'ListCustomerFailure{error: $error}';
  }
}
