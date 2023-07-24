import 'package:rpg_story/Models/Profile.dart';
import 'package:rpg_story/main.dart';

class AuthenticationRepository {
  Future<Profile> getLoggedInUserProfile() async {
    final user = supabase.auth.currentUser;

    final response =
        await supabase.from('profiles').select('*').eq('id', user!.id).single();

    return Profile.fromMap(response);
  }
}
