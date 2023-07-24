import 'package:flutter/material.dart';
import 'package:rpg_story/Pages/CreateAccountPage.dart';
import 'package:rpg_story/Pages/HomePage.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              if (snapshot.hasData) {
                return const HomePage();
              } else {
                return const CreateAccount();
              }
            }
          },
        ),
      ),
    );
  }
}
