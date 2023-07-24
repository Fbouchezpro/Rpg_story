import 'package:flutter/material.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedRotation(
              turns: 3,
              duration: const Duration(milliseconds: 100),
              child: SizedBox(
                width: 100,
                height: 100,
                child: Image.asset(
                  'assets/logo.png',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
