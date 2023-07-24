import 'package:flutter/material.dart';
import 'package:rpg_story/Pages/CalendarPage.dart';
import 'package:rpg_story/Pages/ListBoardGamesPage.dart';
import 'package:rpg_story/Pages/Chat/ListDiscussionsPage.dart';
import 'package:rpg_story/Pages/WelcomePage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rpg_story/Utils/Constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.username}) : super(key: key);

  final String? username;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: BG_COLOR,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: SECONDARY_COLOR,
        unselectedItemColor: Colors.white,
        unselectedFontSize: 8,
        unselectedIconTheme: const IconThemeData(size: 15),
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.house_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.messenger_outline_outlined),
            label: 'Messenger',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.bullseye,
            ),
            label: 'BoardGames',
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          WelcomePage(username: widget.username!),
          Navigator(
            initialRoute: '/',
            onGenerateRoute: (settings) {
              late Widget page;
              if (settings.name == '/') {
                page = const CalendarPage();
              }
              return MaterialPageRoute(builder: (_) => page);
            },
          ),
          Navigator(
            initialRoute: '/',
            onGenerateRoute: (settings) {
              late Widget page;
              if (settings.name == '/') {
                page = const DiscussionListPage();
              }
              return MaterialPageRoute(builder: (_) => page);
            },
          ),
          Navigator(
            initialRoute: '/',
            onGenerateRoute: (settings) {
              late Widget page;
              if (settings.name == '/') {
                page = BoardGamesPage();
              }
              return MaterialPageRoute(builder: (_) => page);
            },
          ),
        ],
      ),
    );
  }
}
