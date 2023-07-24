import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  final String message;
  final Color backgroundColor;

  const CustomSnackBar({
    Key? key,
    required this.message,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    ));
  }
}

class CustomErrorSnackBar extends StatelessWidget {
  final String message;

  const CustomErrorSnackBar({Key? key, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSnackBar(
      message: message,
      backgroundColor: Colors.red,
    );
  }
}
