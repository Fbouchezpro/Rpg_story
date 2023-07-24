import 'package:flutter/material.dart';

class BoardGamesPage extends StatelessWidget {
  final List<String> boardGames = [
    'Monopoly',
    'Catan',
    'Ticket to Ride',
    'Codenames',
    'Pandemic',
    'Scrabble',
    'Splendor',
    'Carcassonne',
    'Azul',
    '7 Wonders',
  ];

  BoardGamesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Board Games'),
      ),
      body: ListView.builder(
        itemCount: boardGames.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(boardGames[index]),
            onTap: () {
              // Handle the tap on the board game
              // For example, navigate to a details page for the selected game
            },
          );
        },
      ),
    );
  }
}
