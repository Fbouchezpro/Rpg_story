import 'package:flutter/material.dart';
import 'package:rpg_story/Models/Message.dart';
import 'package:rpg_story/Models/Profile.dart';
import 'package:rpg_story/Utils/ColorsUtils.dart';
import 'package:rpg_story/Utils/Constants.dart';
import 'package:rpg_story/Utils/DateUtils.dart';
import 'package:rpg_story/Widgets/CustomUserAvatar.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({
    Key? key,
    required this.message,
    required this.profile,
  }) : super(key: key);

  final Message message;
  final Profile? profile;

  @override
  Widget build(BuildContext context) {
    List<Widget> chatContents = [
      if (!message.isMine)
        CustomUserAvatar(
          text: profile == null
              ? "Anonymous".substring(0, 2)
              : profile!.username.substring(0, 2),
          backgroundColor: profile == null
              ? generateColorFromString("Anonymous")
              : generateColorFromString(profile!.username),
          avatarUrl: profile == null ? null : profile!.avatarUrl,
        ),
      GAP_W_8,
      Flexible(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            color: message.isMine
                ? Theme.of(context).primaryColor
                : Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(message.content),
        ),
      ),
      const SizedBox(width: 12),
      Text(
        displayBeautifulShortHour(
          date: message.createdAt,
          use24HourFormat: true,
        ),
      ),
      const SizedBox(width: 60),
    ];
    if (message.isMine) {
      chatContents = chatContents.reversed.toList();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
      child: Row(
        mainAxisAlignment:
            message.isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: chatContents,
      ),
    );
  }
}
