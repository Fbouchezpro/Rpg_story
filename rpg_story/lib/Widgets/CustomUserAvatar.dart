import 'package:flutter/material.dart';

class CustomUserAvatar extends StatelessWidget {
  final String? avatarUrl;
  final String text;
  final Color backgroundColor;
  final double threshold;
  final bool isOnline;

  const CustomUserAvatar({
    Key? key,
    this.avatarUrl,
    required this.text,
    required this.backgroundColor,
    this.threshold = 128,
    this.isOnline = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double luminance = (0.299 * backgroundColor.red +
            0.587 * backgroundColor.green +
            0.114 * backgroundColor.blue) /
        255;

    Color textColor = luminance > threshold ? Colors.black : Colors.white;

    return Stack(
      children: [
        if (avatarUrl != null)
          CircleAvatar(
            backgroundImage: NetworkImage(avatarUrl!),
          ),
        if (avatarUrl == null)
          CircleAvatar(
            backgroundColor: backgroundColor,
            child: Text(
              text,
              style: TextStyle(color: textColor),
            ),
          ),
        if (isOnline)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.lightGreen,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}
