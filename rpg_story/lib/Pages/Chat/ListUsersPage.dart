import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rpg_story/Utils/ColorsUtils.dart';
import 'package:rpg_story/Widgets/CustomUserAvatar.dart';
import 'package:rpg_story/main.dart';
import 'package:supabase/supabase.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  UserListPageState createState() => UserListPageState();
}

class UserListPageState extends State<UserListPage> {
  List<Map<String, dynamic>> _users = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    final response = await supabase.from("profiles").select("*");
    final data = response as List<dynamic>;
    setState(() {
      _users =
          data.map((userData) => userData as Map<String, dynamic>).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_users);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start a discussion with...'),
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    if (_users.isEmpty) {
      return const Center(child: Text('Aucun utilisateur trouvé.'));
    } else {
      return ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Card(
              child: ListTile(
                leading: CustomUserAvatar(
                  text: user['username']?.substring(0, 2) ?? '',
                  backgroundColor:
                      generateColorFromString(user['username'] ?? ''),
                  isOnline: user['isOnline'] ?? true,
                  avatarUrl: user['avatar_url'],
                ),
                title: Text(user['username'] ?? ''),
                trailing: const Icon(Icons.arrow_circle_right_outlined),
              ),
            ),
          );
        },
      );
    }
  }
}
