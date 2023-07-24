// ignore_for_file: constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:rpg_story/Pages/CalendarPage.dart';
import 'package:rpg_story/Pages/Chat/ChatPage.dart';
import 'package:rpg_story/Pages/HomePage.dart';
import 'package:rpg_story/Pages/ListBoardGamesPage.dart';
import 'package:rpg_story/Pages/Chat/ListDiscussionsPage.dart';
import 'package:rpg_story/Pages/LoginPage.dart';
import 'package:rpg_story/Pages/ProfilPage.dart';
import 'package:rpg_story/Pages/WelcomePage.dart';

class AppRoutes {
  static const String login = '/';
  static const String home = '/home';
  static const String profil = '/profil';
  static const String calendar = '/calendar';
  static const String chat = '/chat';
  static const String welcome = '/welcome';
  static const String listBoardGame = '/boardgames';

  static const String ROUTE_NAME_HOME = 'Home';
  static const String ROUTE_NAME_LOGIN = 'Connexion';
  static const String ROUTE_NAME_PROFIL = 'Profil';
  static const String ROUTE_NAME_AGENDA = 'Agenda';
  static const String ROUTE_NAME_CHAT = 'Chat';
  static const String ROUTE_NAME_WELCOME = 'Welcome';
  static const String ROUTE_NAME_BOARD_GAMES = 'Board Games';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return _customPageRoute(
            page: const LoginPage(),
            pageName: AppRoutes.ROUTE_NAME_LOGIN,
            pageArguments: settings.arguments);
      case home:
        final args = settings.arguments as String?;
        return _customPageRoute(
            page: HomePage(username: args),
            pageName: AppRoutes.ROUTE_NAME_HOME,
            pageArguments: settings.arguments);
      case welcome:
        final args = settings.arguments as String;
        return _customPageRoute(
            page: WelcomePage(username: args),
            pageName: AppRoutes.ROUTE_NAME_WELCOME,
            pageArguments: settings.arguments);
      case profil:
        return _customPageRoute(
            page: const ProfilePage(),
            pageName: AppRoutes.ROUTE_NAME_PROFIL,
            pageArguments: settings.arguments);
      case calendar:
        return _customPageRoute(
            page: const CalendarPage(),
            pageName: AppRoutes.ROUTE_NAME_AGENDA,
            pageArguments: settings.arguments);
      case chat:
        return _customPageRoute(
            page: const DiscussionListPage(),
            pageName: AppRoutes.ROUTE_NAME_CHAT,
            pageArguments: settings.arguments);
      case listBoardGame:
        return _customPageRoute(
            page: BoardGamesPage(),
            pageName: AppRoutes.ROUTE_NAME_BOARD_GAMES,
            pageArguments: settings.arguments);
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('Page introuvable'),
            ),
          );
        });
    }
  }
}

MaterialPageRoute<dynamic> _customPageRoute({
  required Widget page,
  required String? pageName,
  required Object? pageArguments,
}) {
  return MaterialPageRoute<dynamic>(
    builder: (BuildContext context) {
      return page;
    },
    settings: RouteSettings(
      name: pageName,
      arguments: pageArguments,
    ),
  );
}
