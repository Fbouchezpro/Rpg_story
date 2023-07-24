import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  Future<String?> registration({
    required String email,
    required String password,
    required String username,
  }) async {
    final supabase = Supabase.instance.client;

    try {
      final response = await supabase.auth.signUp(
          email: email, password: password, data: {'username': username});
      return 'Success';
    } on AuthException catch (e) {
      if (e.message == 'weak_password') {
        return 'The password provided is too weak.';
      } else if (e.message == 'unique_violation') {
        return 'The account already exists for that email.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    final supabase = Supabase.instance.client;

    try {
      await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return 'Success';
    } on AuthException catch (e) {
      if (e.message == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.message == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
