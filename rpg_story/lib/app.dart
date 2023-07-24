import 'package:flutter/material.dart';
import 'package:rpg_story/Pages/LoginPage.dart';
import 'package:rpg_story/Utils/Constants.dart';
import 'package:rpg_story/Utils/Routes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BoardGame Story',
      home: const LoginPage(),
      initialRoute: AppRoutes.login,
      onGenerateRoute: AppRoutes.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        primaryColor: PRIMARY_COLOR,
        backgroundColor: BG_COLOR,
        focusColor: SECONDARY_COLOR,
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: SECONDARY_COLOR),
        dialogBackgroundColor: const Color(0xFF87CEEB),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: SECONDARY_COLOR,
            onSurface: Colors.black,
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: BG_COLOR,
        ),
        inputDecorationTheme: InputDecorationTheme(
          floatingLabelStyle: const TextStyle(
            color: Colors.orange,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 2,
            ),
          ),
          focusColor: Colors.orange,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.orange,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
