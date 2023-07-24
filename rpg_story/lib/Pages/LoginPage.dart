// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:rpg_story/Pages/CreateAccountPage.dart';
import 'package:rpg_story/Services/auth_service.dart';
import 'package:rpg_story/Utils/Constants.dart';
import 'package:rpg_story/Utils/Routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordObscured = true;

  void _login(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwordController.text;

    final message = await AuthService().login(
      email: email,
      password: password,
    );
    if (message!.contains('Success')) {
      Navigator.pushNamed(context, AppRoutes.home, arguments: email);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erreur de connexion'),
          content: const Text(
              'Veuillez saisir un email et un mot de passe valides.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordObscured = !_isPasswordObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3B3B3B),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage('assets/main_logo.png')),
            const Text(
              "Welcome on BOARDGAME STORY",
              style: TextStyle(color: Colors.white),
            ),
            _buildUsernameInput(),
            GAP_H_16,
            _buildPasswordInput(),
            GAP_H_16,
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                onPressed: () => _login(context),
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CreateAccount(),
                  ),
                );
              },
              child: const Text(
                'Create Account',
                style: TextStyle(
                    color: Colors.white, decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextField _buildUsernameInput() {
    return TextField(
      controller: _emailController,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: 'E-mail',
        focusColor: SECONDARY_COLOR,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: SECONDARY_COLOR, width: 2.0),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: PRIMARY_COLOR.withOpacity(0.3),
            width: 2.0,
          ),
        ),
        labelStyle: TextStyle(
          color: SECONDARY_COLOR.withOpacity(0.7),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  TextField _buildPasswordInput() {
    return TextField(
      controller: _passwordController,
      obscureText: _isPasswordObscured,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: _togglePasswordVisibility,
          icon: Icon(
            _isPasswordObscured
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: Colors.white,
          ),
        ),
        labelText: 'Password',
        focusColor: SECONDARY_COLOR,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: SECONDARY_COLOR, width: 2.0),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: PRIMARY_COLOR.withOpacity(0.3),
            width: 2.0,
          ),
        ),
        labelStyle: TextStyle(
          color: SECONDARY_COLOR.withOpacity(0.7),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
