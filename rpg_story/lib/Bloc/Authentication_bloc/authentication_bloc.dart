import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:rpg_story/Bloc/Authentication_bloc/authentication_repository.dart';
import 'package:rpg_story/Models/Profile.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;

  AuthenticationBloc({required this.authenticationRepository})
      : super(AuthenticationInitial()) {
    on<FetchingCurrentUserProfile>(_onFetchingCurrentUserProfil);
  }

  Future<Profile> _onFetchingCurrentUserProfil(
    FetchingCurrentUserProfile event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    try {
      Profile currentUser =
          await authenticationRepository.getLoggedInUserProfile();
      emit(AuthenticationDone(user: currentUser));
      return currentUser;
    } catch (error) {
      emit(AuthenticationFailure(error: Error()));
      throw error;
    }
  }
}
