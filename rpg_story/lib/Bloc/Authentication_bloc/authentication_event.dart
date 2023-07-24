part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {}

class FetchingCurrentUserProfile extends AuthenticationEvent {
  final Profile profile;

  FetchingCurrentUserProfile(this.profile);
}
