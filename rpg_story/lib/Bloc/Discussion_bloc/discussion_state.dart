part of 'discussion_bloc.dart';

abstract class DiscussionState {}

class DiscussionInitial extends DiscussionState {}

class ListDiscussionsLoading extends DiscussionState {}

class ListDiscussionsDone extends DiscussionState {
  final List<Discussion> listDiscussions;

  ListDiscussionsDone({required this.listDiscussions});
}

class ListDiscussionsFailure extends DiscussionState {
  final Error error;

  ListDiscussionsFailure({required this.error});

  @override
  String toString() {
    return 'ListDiscussionsFailure{error: $error}';
  }
}
