part of 'authentication_bloc.dart';

abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationDone extends AuthenticationState {
  final Profile user;

  AuthenticationDone({required this.user});
}

class AuthenticationFailure extends AuthenticationState {
  final Error error;

  AuthenticationFailure({required this.error});

  @override
  String toString() {
    return 'ListDiscussionsFailure{error: $error}';
  }
}
