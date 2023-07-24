import 'package:flutter/material.dart';
import 'package:rpg_story/Utils/Routes.dart';
import 'package:rpg_story/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WelcomePage extends StatelessWidget {
  final String username;

  const WelcomePage({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? currentUser = supabase.auth.currentUser;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.settings,
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.profil);
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.logout_outlined,
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.login);
                    },
                  ),
                ],
              ),
              const Image(
                image: AssetImage('assets/main_logo_light.png'),
              ),
              Center(
                child: Text(
                  'Welcome ${currentUser?.userMetadata?['username'] ?? currentUser?.email}',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  '''
                  Welcome to our app dedicated to organizing board game nights!

                  Whether you're a seasoned board game enthusiast or simply curious to explore new gaming experiences, you've come to the right place. Our app is designed to help you plan and organize unforgettable game nights with your friends, family, or even new acquaintances.

                  Explore our vast collection of board games, ranging from timeless classics to the latest releases. Whether you prefer strategy games, cooperative games, card games, or party games, you're sure to find something that suits your taste. Our app allows you to browse game descriptions, rules, and reviews, so you can make an informed choice for your game night.

                  Once you've selected the games that interest you, use our scheduling feature to create events. Invite your friends, set the date, time, and location for the board game night, and easily share the details with all participants. You can also add specific notes or instructions for each game, so everyone is ready to play from the start.

                  During the event, our app offers convenient assistance. You can track scores, keep time, or even utilize special features unique to certain games. Our goal is to make organizing your board game nights as smooth and enjoyable as possible.

                  Remember, board games are not only fun but also provide a great opportunity to strengthen social bonds, promote communication, and create lasting memories. So gather your friends, get snacks and drinks ready, and dive into a night filled with laughter, friendly competition, and shared moments.

                  We wish you lots of fun and exciting discoveries with our board game night organization app. May each night be a unique and memorable adventure!

                  Enjoy!
                  ''',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
