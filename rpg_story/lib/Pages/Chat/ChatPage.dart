import 'package:flutter/material.dart';
import 'package:rpg_story/Models/Message.dart';
import 'package:rpg_story/Models/Profile.dart';
import 'package:rpg_story/Utils/Constants.dart';
import 'package:rpg_story/Widgets/ChatMessage.dart';
import 'package:rpg_story/Widgets/CustomSnackBar.dart';
import 'package:rpg_story/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatPage extends StatefulWidget {
  final String discussionId;
  const ChatPage({Key? key, required this.discussionId}) : super(key: key);

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  late final Stream<List<Message>> _messagesStream;
  final Map<String, Profile> _profileCache = {};
  void _sendMessage() async {
    final text = _messageController.text;
    final myUserId = supabase.auth.currentUser!.id;
    if (text.isEmpty) {
      return;
    }
    _messageController.clear();
    try {
      await supabase.from('messages').insert({
        'profile_id': myUserId,
        'content': text,
        'discussion_id': widget.discussionId,
      });
    } on PostgrestException catch (error) {
      CustomErrorSnackBar(message: error.message);
    }
  }

  @override
  void initState() {
    final myUserId = supabase.auth.currentUser!.id;
    final discussionId = widget.discussionId;
    _messagesStream = supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('discussion_id', discussionId)
        .order('created_at')
        .map((maps) => maps
            .map((map) => Message.fromMap(map: map, myUserId: myUserId))
            .toList());
    super.initState();
  }

  Future<void> _loadProfileCache(String profileId) async {
    if (_profileCache[profileId] != null) {
      return;
    }
    final data =
        await supabase.from('profiles').select().eq('id', profileId).single();
    final profile = Profile.fromMap(data);
    setState(() {
      _profileCache[profileId] = profile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: StreamBuilder<List<Message>>(
        stream: _messagesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading messages.'),
            );
          } else if (snapshot.hasData) {
            final messages = snapshot.data!;
            return Column(
              children: [
                GAP_H_8,
                Expanded(
                  child: messages.isEmpty
                      ? const Center(
                          child: Text('Start your conversation now :)'),
                        )
                      : ListView.builder(
                          reverse: true,
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            _loadProfileCache(message.profileId);

                            return ChatMessage(
                              message: message,
                              profile: _profileCache[message.profileId],
                            );
                          },
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(
                              color: Colors.black,
                            ),
                            hintText: 'Enter your message...',
                          ),
                        ),
                      ),
                      GAP_W_8,
                      Container(
                        decoration: const BoxDecoration(
                            color: PRIMARY_COLOR, shape: BoxShape.circle),
                        child: IconButton(
                          icon: const Icon(Icons.send, color: Colors.black),
                          onPressed: _sendMessage,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
