part of 'discussion_bloc.dart';

abstract class DiscussionEvent {}

class RequestingDiscussionsEvent extends DiscussionEvent {
  final Profile profile;

  RequestingDiscussionsEvent({required this.profile});
}
