import 'package:rpg_story/Models/Discussion.dart';
import 'package:rpg_story/Models/Profile.dart';
import 'package:rpg_story/main.dart';

class DiscussionRepository {
  Future<List<Discussion>> fetchDiscussions({required Profile user}) async {
    final response = await supabase
        .from('discussions')
        .select('*')
        .contains('users', [(user.id)]);
    final discussions = response as List<dynamic>;
    print(response);
    return discussions.map((data) => Discussion.fromJson(data)).toList();
  }
}
