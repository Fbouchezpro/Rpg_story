import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:rpg_story/Bloc/Discussion_bloc/discussion_repository.dart';
import 'package:rpg_story/Models/Discussion.dart';
import 'package:rpg_story/Models/Profile.dart';

part 'discussion_event.dart';
part 'discussion_state.dart';

class DiscussionBloc extends Bloc<DiscussionEvent, DiscussionState> {
  final DiscussionRepository discussionRepository;
  DiscussionBloc({required this.discussionRepository})
      : super(DiscussionInitial()) {
    on<RequestingDiscussionsEvent>(_onRequestingListDiscussions);
  }

  FutureOr<void> _onRequestingListDiscussions(
      RequestingDiscussionsEvent event, Emitter<DiscussionState> emit) async {
    emit(ListDiscussionsLoading());
    try {
      List<Discussion> discussionsList =
          await discussionRepository.fetchDiscussions(user: event.profile);
      emit(ListDiscussionsDone(listDiscussions: discussionsList));
    } catch (error) {
      emit(ListDiscussionsFailure(error: Error()));
    }
  }
}
